//
//  GameplayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		@State var currentGame: GameplayModel

		@State private var showSettings: Bool = false
		@State private var showEndRound = false
		
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
												
												VStack (alignment: .leading) {
														Text("Difficulty:")
																.bold()
														Text(currentGame.difficulty.rawValue)
												}
												
												Spacer()
												
												VStack {
														Text("Score")
																.bold()
														Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												
												Spacer()
												
												VStack {
														Text("Time")
																.bold()
														Text(formattedTime(currentGame: currentGame, elapsedTime: elapsedTime))
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												Spacer()
										}
										
										Spacer()
										
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		stopTimer()
																		currentGame.elapsedTime = elapsedTime
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.opacity(0.7)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		currentGame.score += 1
																		stopTimer()
																		currentGame.elapsedTime = elapsedTime
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
												}
												
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		stopTimer()
																		currentGame.elapsedTime = elapsedTime
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		stopTimer()
																		currentGame.elapsedTime = elapsedTime
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
												}
										}
										.foregroundStyle(.orange)
										.padding(.bottom, 50)
										
										Spacer()
								}
								.toolbar {
										ToolbarItem {
												Button(action: {
														showSettings = true
												}, label: {
														Image(systemName: "gear")
																.foregroundStyle(Color("Primary Black"))
												})
										}
										
										ToolbarItem(placement: .topBarLeading) {
												Button(action: {
																viewStates.showPause.toggle()
												}, label: {
														Image(systemName: viewStates.showPause ? "play.fill" : "pause.fill")
																.foregroundStyle(Color("Primary Black"))
												})
										}
								}

								if viewStates.showPause {
										PauseGameView(currentGame: currentGame)
												.onAppear {
														pauseResumeTimer()
												}
												.onDisappear {
														pauseResumeTimer()
												}
								}
								
								if viewStates.showEndRound {
										RoundFinishedView(currentGame: currentGame)
												.transition(.push(from: .bottom))
								}
						}
				}
				.sheet(isPresented: $showSettings, content: {
						SettingsView()
				})
				.onAppear {
						startTimer()
				}
		}
		
		func formattedTime(currentGame: GameplayModel, elapsedTime: TimeInterval) -> String {
				let minutes = Int(elapsedTime) / 60
				let seconds = Int(elapsedTime) % 60
				currentGame.elapsedTimeString = String(format: "%02d:%02d", minutes, seconds)
				return currentGame.elapsedTimeString
		}

		func startTimer() {
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

		func stopTimer() {
				timer?.invalidate()
				timer = nil

				if let start = startTime {
						elapsedTime = Date().timeIntervalSince(start)
				}
				startTime = nil
				pausedTime = 0
				isPaused = false
		}

		func pauseResumeTimer() {
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
