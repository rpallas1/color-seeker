//
//  RoundFinishedView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

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
		
		@State var currentGame: GameplayModel
		@State private var showHome = false
		private var calc = CalcStats()
		
    var body: some View {
				
				@Bindable var viewStates = viewStates
				
				VStack (spacing: 16) {
						if calc.didPassRound(currentGame: currentGame) {
								Text("Round Complete")
										.font(.largeTitle)
										.bold()
						} else {
								Text("Round Failed")
										.font(.largeTitle)
										.bold()
						}
						
						Text("\(calc.percentCorrect(currentGame: currentGame))%")
								.font(.title)
						
						VStack (spacing: 4) {
								Text("Difficulty")
										.bold()
								Text(currentGame.difficulty.rawValue)
						}
						.font(.title2)
						
						VStack (spacing: 4) {
								Text("Time")
										.bold()
								Text(currentGame.elapsedTimeString)
						}
						.font(.title2)
						
						VStack (spacing: 4) {
								Text("Score")
										.bold()
								Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
						}
						.font(.title2)
						
						Button(action: {
								viewStates.showGameplay = false
								viewStates.showEndRound = false
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
								
								stat.gamesPlayed += 1
								overallStat.gamesPlayed += 1
						
								stat.totalTime += currentGame.elapsedTime
								overallStat.totalTime += currentGame.elapsedTime
								
								if calc.didPassRound(currentGame: currentGame) {
										stat.gamesWon += 1
										overallStat.gamesWon += 1
								}
								
								if calc.isPerfectRound(currentGame: currentGame) {
										stat.perfectGames += 1
										overallStat.perfectGames += 1
								}
								
								if calc.resetStreak(currentGame: currentGame) {
										stat.currentStreak = 0
										overallStat.currentStreak = 0
								} else {
										stat.currentStreak += 1
										overallStat.currentStreak += 1
								}
								
								stat.percentCorrect = calc.winRate(stat: stat)
								overallStat.percentCorrect = calc.winRate(stat: overallStat)
								
								stat.bestStreak = calc.bestStreak(currentStreak: stat.currentStreak, bestStreak: stat.bestStreak)
								overallStat.bestStreak = calc.bestStreak(currentStreak: overallStat.currentStreak, bestStreak: overallStat.bestStreak)
								
								if calc.didPassRound(currentGame: currentGame) {
										stat.bestTime = calc.bestTime(currentTime: currentGame.elapsedTime, bestTime: stat.bestTime)
										stat.bestTimeString = calc.formatTime(elapsedTime: stat.bestTime)
								}
								
								stat.averageTime = calc.averageTime(gamesPlayed: stat.gamesPlayed, totalTime: stat.totalTime)
								stat.averageTimeString = calc.formatTime(elapsedTime: stat.averageTime)
								overallStat.averageTime = calc.averageTime(gamesPlayed: overallStat.gamesPlayed, totalTime: overallStat.totalTime)
								overallStat.averageTimeString = calc.formatTime(elapsedTime: overallStat.averageTime)
								
 								currentGame.score = 0
								currentGame.totalTaps = 0
						} else {
								print("Error: Returned more than 1 stat difficulty or overall stat")
						}
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

