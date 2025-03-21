//
//  GameplayView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftUI

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		@Environment(Settings.self) var settings
		@Environment(\.scenePhase) private var scenePhase
		
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
		
		@State var barSegmentColor: Color = .accent
		
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
																.foregroundStyle(.accent)
														Text(currentGame.difficulty.rawValue)
												}
												
												Spacer()
												
												VStack {
														Text("Score")
																.bold()
																.foregroundStyle(.accent)
														Text("\(currentGame.score)")
												}
												
												if currentGame.difficulty != .survival {
														Spacer()
														
														VStack {
																Text("Round")
																		.bold()
																		.foregroundStyle(.accent)
																Text("\(currentGame.totalTaps)/\(currentGame.totalRounds)")
														}
												}
												
												Spacer()
												
												VStack {
														Text("Time")
																.bold()
																.foregroundStyle(.accent)
														Text(formattedTime(currentGame: currentGame, elapsedTime: elapsedTime))
																.monospacedDigit()
												}
												
												Spacer()
										}
										.padding(.top, 16)
										
										if currentGame.difficulty != .survival {
												GeometryReader { geometry in
														HStack(spacing: 0) {
																ForEach(0..<currentGame.tapResults.count, id: \.self) { index in
																		Rectangle()
																				.foregroundStyle(self.colorForSegment(at: index))
																				.frame(width: geometry.size.width / CGFloat(currentGame.tapResults.count), height: 5)
																}
														}
												}
												.frame(height: 5)
												.padding(.top, 6)
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
																				currentGame.handleCorrectTap()
																				isAnswer = true
																		} else {
																				currentGame.handleIncorrectTap()
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
																						gridArray = game.buildGrid(currentGame: currentGame, colorScheme: settings.referenceColor(for: settings.colorScheme))
																				} else {
																						gridArray = game.buildGrid(currentGame: currentGame, colorScheme: settings.referenceColor(for: settings.colorScheme))
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
						game.screenWidth = UIScreen.main.bounds.width
						game.screenHeight = UIScreen.main.bounds.height
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
						GameFinishedView(currentGame: currentGame)
								.transition(.push(from: .bottom))
				})
				.onDisappear {
						viewStates.showEndRound = false
						viewStates.showPause = false
				}
				.onChange(of: scenePhase) { oldPhase, newPhase in
						if newPhase == .background || newPhase == .inactive {
								currentGame.elapsedTime = elapsedTime
								viewStates.showPause = true
						}
				}
				.onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
						currentGame.elapsedTime = elapsedTime
						viewStates.showPause = true
				}
		}
		
		private func formattedTime(currentGame: GameplayModel, elapsedTime: TimeInterval) -> String {
				let hours = Int(elapsedTime) / 3600
				let minutes = (Int(elapsedTime) % 3600) / 60
				let seconds = Int(elapsedTime) % 60

				if hours > 0 {
						currentGame.elapsedTimeString = String(format: "%d:%02d:%02d", hours, minutes, seconds)
				} else {
						currentGame.elapsedTimeString = String(format: "%02d:%02d", minutes, seconds)
				}
				
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
		
		private func colorForSegment(at index: Int) -> Color {
				if let result = currentGame.tapResults[index] {
						return result ? .accent : .red
				} else {
						return Color("Primary Gray")
				}
		}
}
