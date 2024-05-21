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
		
		var currentGame: GameplayModel
		@State private var showHome = false

		
    var body: some View {
				
				@Bindable var viewStates = viewStates
				
				VStack (spacing: 16) {
						
						if currentGame.wonRound {
								Text("Round Complete")
										.font(.largeTitle)
										.bold()
						} else {
								Text("Round Failed")
										.font(.largeTitle)
										.bold()
						}
						
						Text("100%")
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
								Text("00:02")
						}
						.font(.title2)
						
						VStack (spacing: 4) {
								Text("Score")
										.bold()
								Text(String(currentGame.score))
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
						RoundedRectangle(cornerRadius: 8)
								.foregroundStyle(Color("Primary Gray"))
								.shadow(radius: 6)
				}
				.onAppear {
						if difficultyStat.count == 1 && overallStat.count == 1 {
								let stat = difficultyStat[0]
								let overallStat = overallStat[0]
								
								// Update difficulty stat
								stat.gamesPlayed += 1
								stat.currentStreak += 1
								overallStat.gamesPlayed += 1
								
								// Rest current game
								currentGame.score = 0
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

