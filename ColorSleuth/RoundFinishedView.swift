//
//  RoundFinishedView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData
import TelemetryDeck

struct RoundFinishedView: View {
		
		@Environment(GlobalStates.self) var viewStates
		@Environment(\.modelContext) private var context
		@Environment(\.dismiss) var dismiss
		
		@Query(filter: #Predicate<StatModel> { stat in
				stat.difficulty == "Medium"
		})
		private var difficultyStat: [StatModel]
		
		@Query(filter: #Predicate<StatModel> { stat in
				stat.difficulty == "Overall"
		})
		private var overallStat: [StatModel]
		
		// TODO: Query all stats to use in analytics
		
		@State var currentGame: GameplayModel
		@State private var showHome = false
		private var calc = CalcStats()
		private var format = FormatHelper()
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				VStack (spacing: 16) {
						if currentGame.difficulty != .survival {
								if calc.didPassRound(currentGame: currentGame) {
										Text("Round Complete")
												.font(.largeTitle)
												.bold()
								} else {
										Text("Round Failed")
												.font(.largeTitle)
												.bold()
								}
								
								Text(format.percent(percent: calc.percentCorrect(currentGame: currentGame)))
										.font(.title)
						}
						
						VStack (spacing: 4) {
								Text("Difficulty")
										.bold()
								Text(currentGame.difficulty.rawValue)
						}
						.font(.title2)
						
						VStack (spacing: 4) {
								Text("Time")
										.bold()
								Text(format.time(elapsedTime: Double(currentGame.elapsedTime)))
						}
						.font(.title2)
						
						VStack (spacing: 4) {
								Text("Score")
										.bold()
								
								if currentGame.difficulty == .survival {
										Text(String(currentGame.score))
								} else {
										Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
								}
						}
						.font(.title2)
						
						Button(action: {
								viewStates.showGameplay = false
						}, label: {
								ZStack {
										RoundedRectangle(cornerRadius: 100)
												.frame(width: 239, height: 50)
												.foregroundStyle(.cyan)
										
										Text("Play Again")
												.foregroundStyle(.white)
												.font(.title2)
												.bold()
								}
						})
				}
				.padding()
				.padding(.horizontal, 20)
				.background {
						RoundedRectangle(cornerRadius: 12)
								.foregroundStyle(Color("Primary Gray"))
								.shadow(radius: 6)
				}
				.onAppear {
						//Update all stats
						if difficultyStat.count == 1 && overallStat.count == 1 {
								
								let stat = difficultyStat[0]
								let overallStat = overallStat[0]
								
								// ROOT STATS
								if !(currentGame.score == 0 && currentGame.difficulty == .survival) {
										stat.gamesPlayed += 1
										stat.totalTime += currentGame.elapsedTime
								}
								
								stat.totalTaps += currentGame.totalTaps
								stat.correctTaps += currentGame.score
								
								if currentGame.difficulty == .survival {
										if currentGame.score > stat.highScore {
												stat.highScore = calc.highScore(currentScore: currentGame.score, highScore: stat.highScore)
												stat.bestTimeTapRatio = calc.currentTimeTapRatio(currentGame: currentGame)
												stat.bestTimeTapRatioString = format.time(elapsedTime: stat.bestTimeTapRatio)
												stat.bestTime = currentGame.elapsedTime
												stat.bestTimeString = format.time(elapsedTime: stat.bestTime)
										}
										
										if currentGame.score != 0 {
												stat.averageScore = calc.averageScore(correctTaps: stat.correctTaps, gamesPlayed: stat.gamesPlayed)
												stat.avgTimeTapRatio = calc.avgTimeTapRatio(stats: stat)
												stat.avgTimeTapRatioString = format.time(elapsedTime: stat.avgTimeTapRatio)
												stat.averageTime = calc.averageTime(gamesPlayed: stat.gamesPlayed, totalTime: stat.totalTime)
												stat.averageTimeString = format.time(elapsedTime: stat.averageTime)
										}
								}
								
								if currentGame.difficulty != .survival {
										// ROOT STATS
										overallStat.gamesPlayed += 1
										overallStat.totalTime += currentGame.elapsedTime
										overallStat.totalTaps += currentGame.totalTaps
										overallStat.correctTaps += currentGame.score
										
										if calc.didPassRound(currentGame: currentGame) {
												stat.gamesWon += 1
												overallStat.gamesWon += 1
												
												stat.currentStreak += 1
												overallStat.currentStreak += 1
										} else {
												stat.currentStreak = 0
												overallStat.currentStreak = 0
										}
										
										if calc.isPerfectRound(currentGame: currentGame) {
												stat.perfectGames += 1
												overallStat.perfectGames += 1
										}
										
										stat.percentCorrect = calc.winRate(stat: stat)
										overallStat.percentCorrect = calc.winRate(stat: overallStat)
										
										stat.accuracy = calc.accuracy(stat: stat)
										overallStat.accuracy = calc.accuracy(stat: overallStat)
										
										stat.bestStreak = calc.bestStreak(currentStreak: stat.currentStreak, bestStreak: stat.bestStreak)
										overallStat.bestStreak = calc.bestStreak(currentStreak: overallStat.currentStreak, 
																														 bestStreak: overallStat.bestStreak)
										
										if calc.didPassRound(currentGame: currentGame) {
												stat.bestTime = calc.bestTime(currentTime: currentGame.elapsedTime, bestTime: stat.bestTime)
												stat.bestTimeString = format.time(elapsedTime: stat.bestTime)
										}
										
										stat.averageTime = calc.averageTime(gamesPlayed: stat.gamesPlayed, totalTime: stat.totalTime)
										stat.averageTimeString = format.time(elapsedTime: stat.averageTime)
										overallStat.averageTime = calc.averageTime(gamesPlayed: overallStat.gamesPlayed, 
																															 totalTime: overallStat.totalTime)
										overallStat.averageTimeString = format.time(elapsedTime: overallStat.averageTime)
								}
								
								// Difficulty Stats Updated
//								TelemetryDeck.signal(
//										"roundPlayed",
//										parameters: [
//												"difficulty": "\(stat.difficulty)",
//												"gamesPlayed": "\(stat.gamesPlayed)",
//												"gamesWon": "\(stat.gamesWon)",
//												"perfectGames": "\(stat.perfectGames)",
//												"highScore": "\(stat.highScore)",
//												"averageScore": "\(stat.averageScore)",
//												"percentCorrect": "\(stat.percentCorrect)",
//												"correctTaps": "\(stat.correctTaps)",
//												"totalTaps": "\(stat.totalTaps)",
//												"accuracy": "\(stat.accuracy)",
//												"currentStreak": "\(stat.currentStreak)",
//												"bestStreak": "\(stat.bestStreak)",
//												"totalTime": "\(stat.totalTime)",
//												"bestTime": "\(stat.bestTime)",
//												"bestTime String": "\(stat.bestTimeString)",
//												"bestTime Tap Ratio": "\(stat.bestTimeTapRatio)",
//												"bestTime Tap Ratio String": "\(stat.bestTimeTapRatioString)",
//												"averageTime Tap Ratio": "\(stat.avgTimeTapRatio)",
//												"averageTime Tap Ratio String": "\(stat.avgTimeTapRatioString)",
//												"averageTime": "\(stat.averageTime)",
//												"averageTime String": "\(stat.averageTimeString)"
//										]
//								)
						} else {
								print("Error: Returned more than 1 stat difficulty or overall stat")
						}
				}
				.onDisappear {
						// Reset current game values
						currentGame.resetProperties()
				}
		}
		
		
		init(currentGame: GameplayModel) {
				// Query only for the difficulty that was played in the current game
				if currentGame.difficulty == Difficulty.easy {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Easy"
						})
				}
				else if currentGame.difficulty == Difficulty.medium {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Medium"
						})
				}
				else if currentGame.difficulty == Difficulty.hard {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Hard"
						})
				}
				else if currentGame.difficulty == Difficulty.extreme {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Extreme"
						})
				}
				else if currentGame.difficulty == Difficulty.survival {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Survival"
						})
				}
				
				self.currentGame = currentGame
		}
}

