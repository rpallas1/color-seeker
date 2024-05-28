//
//  GameplayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftUI

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		@Environment(Settings.self) var settings
		
		@State var currentGame: GameplayModel
		
		@State private var game = GameHelper()
		@State private var showSettings: Bool = false
		@State private var isAnswer = false
		@State var gridArray: [SquareObject]
		
		@State private var timeString: String = ""
		@State private var timer: Timer?
		@State private var startTime: Date?
		@State private var elapsedTime: TimeInterval = 0
		@State private var pausedTime: TimeInterval = 0
		@State private var isPaused: Bool = false
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						ZStack {
								VStack {
										HStack {
												Spacer()
												
												VStack {
														Text("Difficulty")
																.bold()
																.foregroundStyle(.cyan)
														Text(currentGame.difficulty.rawValue)
												}
												
												Spacer()
												
												VStack {
														Text("Score")
																.bold()
																.foregroundStyle(.cyan)
														
														if currentGame.difficulty == .survival {
																Text(String(currentGame.score))
														} else {
																Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
														}
												}
												
												Spacer()
												
												VStack {
														Text("Time")
																.bold()
																.foregroundStyle(.cyan)
														Text(formattedTime(currentGame: currentGame, elapsedTime: elapsedTime))
												}
												.frame(maxWidth: 60)
												
												
												Spacer()
										}
										
										Spacer()
										
										LazyVGrid(columns: Array(repeating: GridItem(.fixed(gridArray[0].dimensions)), count: gridArray[0].sqrtSize)) {
												ForEach(0..<gridArray[0].sqrtSize * gridArray[0].sqrtSize, id: \.self) { i in
														RoundedRectangle(cornerRadius: gridArray[i].cornerRadius)
																.frame(width: gridArray[i].dimensions, height: gridArray[i].dimensions)
																.foregroundStyle(gridArray[i].color)
																.onTapGesture {
																		currentGame.totalTaps += 1
																		if gridArray[i].isAnswer == true {
																				currentGame.score += 1
																				isAnswer = true
																		} else {
																				isAnswer = false
																				
																				// End game since they made one mistake in survival mode
																				if currentGame.difficulty == .survival {
																						stopTimer()
																						currentGame.elapsedTime = elapsedTime
																						
																						withAnimation {
																								viewStates.showEndRound = true
																						}
																				}
																		}
																		
																		if currentGame.totalTaps < currentGame.totalRounds ||
																				(currentGame.difficulty == .survival && isAnswer == true) {
																				// Rebuild grid if game not over
																				if currentGame.difficulty == .survival {
																						gridArray = game.buildGrid(currentGame: currentGame)
																				} else {
																						gridArray = game.buildGrid(currentGame: currentGame)
																				}
																		}
																		else {
																				// Stop game when all rounds are complete
																				stopTimer()
																				currentGame.elapsedTime = elapsedTime
																				
																				withAnimation {
																						viewStates.showEndRound = true
																				}
																		}
																}
																.sensoryFeedback(trigger: currentGame.totalTaps) { oldValue, newValue in
																		if settings.hapticsEnabled {
																				return isAnswer == true ? .impact(intensity: 0.55) : .error
																		}
																		return .none
																}
												}
										}
										.padding(.bottom, 30)
										
										Spacer()
								}
								.disabled(viewStates.showPause)
								.toolbar {
										ToolbarItem {
												Button(action: {
														showSettings = true
														currentGame.elapsedTime = elapsedTime
												}, label: {
														Image(systemName: "gear")
																.foregroundStyle(Color("Primary Black"))
												})
										}
										
										ToolbarItem(placement: .topBarLeading) {
												Button(action: {
														withAnimation {
																viewStates.showPause.toggle()
														}
														currentGame.elapsedTime = elapsedTime
												}, label: {
														Image(systemName: viewStates.showPause ? "play.fill" : "pause.fill")
																.foregroundStyle(Color("Primary Black"))
												})
										}
								}
								.blur(radius: viewStates.showPause ? 3 : 0)
								
								if viewStates.showPause {
										PauseGameView(currentGame: currentGame)
												.animation(.easeInOut(duration: 0.3), value: viewStates.showPause)
												.onAppear {
														pauseResumeTimer()
												}
												.onDisappear {
														pauseResumeTimer()
												}
												.zIndex(2)
								}
						}
				}
				.animation(.easeInOut(duration: 0.3), value: viewStates.showPause)
				.onAppear {
						startTimer()
				}
				.sheet(isPresented: $showSettings, content: {
						SettingsView()
								.onAppear {
										if viewStates.showPause == false {
												pauseResumeTimer()
										}
								}
								.onDisappear {
										if viewStates.showPause == false {
												pauseResumeTimer()
										}
								}
				})
				.fullScreenCover(isPresented: $viewStates.showEndRound, content: {
						RoundFinishedView(currentGame: currentGame)
								.transition(.push(from: .bottom))
				})
				.onDisappear {
						viewStates.showEndRound = false
						viewStates.showPause = false
				}
		}
		
		private func formattedTime(currentGame: GameplayModel, elapsedTime: TimeInterval) -> String {
				let minutes = Int(elapsedTime) / 60
				let seconds = Int(elapsedTime) % 60
				currentGame.elapsedTimeString = String(format: "%02d:%02d", minutes, seconds)
				return currentGame.elapsedTimeString
		}
		
		private func startTimer() {
				if isPaused {
						// Resume timer
						startTime = Date().addingTimeInterval(-pausedTime)
						isPaused = false
				} else {
						// Start new timer
						startTime = Date()
						elapsedTime = 0
						pausedTime = 0
				}
				
				timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
						let dateFormatter = DateFormatter()
						dateFormatter.timeStyle = .medium
						self.timeString = dateFormatter.string(from: Date())
						
						if let start = self.startTime {
								self.elapsedTime = Date().timeIntervalSince(start)
						}
				}
				timer?.fire()
		}
		
		private func stopTimer() {
				timer?.invalidate()
				timer = nil
				
				if let start = startTime {
						elapsedTime = Date().timeIntervalSince(start)
				}
				startTime = nil
				pausedTime = 0
				isPaused = false
		}
		
		private func pauseResumeTimer() {
				if isPaused {
						// Resume timer
						startTimer()
				} else {
						// Pause timer
						if let start = startTime {
								pausedTime = Date().timeIntervalSince(start)
						}
						timer?.invalidate()
						timer = nil
						isPaused = true
				}
		}
}
