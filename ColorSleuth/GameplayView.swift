//
//  GameplayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftUI
import SwiftData

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		@State var currentGame: GameplayModel
		@State private var game = GameHelper()
		
		@State private var showSettings: Bool = false
		@State private var showEndRound = false
		@State var gridArray: [SquareObject]
		@State private var numOfRows: Int = 2
		@State private var numOfColumns: Int = 2
		
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
														Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
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
										
										LazyVGrid(columns: Array(repeating: GridItem(.fixed(gridArray[0].size)), count: currentGame.gridSize.rawValue)) {
												ForEach(0..<currentGame.gridSize.rawValue * currentGame.gridSize.rawValue, id: \.self) { i in
														RoundedRectangle(cornerRadius: gridArray[i].cornerRadius)
																.frame(width: gridArray[i].size, height: gridArray[i].size)
																.foregroundStyle(gridArray[i].color)
																.onTapGesture {
																		currentGame.totalTaps += 1
																		if gridArray[i].isAnswer == true {
																				currentGame.score += 1
																		}
																		
																		if currentGame.totalTaps < currentGame.totalRounds {
																				// Rebuild grid if game not over
																				gridArray = game.buildGrid(currentGame: currentGame)
																		} else {
																				// Stop game when all rounds are complete
																				stopTimer()
																				currentGame.elapsedTime = elapsedTime
																				
																				withAnimation {
																						viewStates.showEndRound = true
																				}
																		}
																}
												}
										}
										.padding(.bottom, 30)
										
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
								.onAppear {
										pauseResumeTimer()
								}
								.onDisappear {
										pauseResumeTimer()
								}
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
