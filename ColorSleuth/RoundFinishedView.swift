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
		@Environment(\.modelContext) var context
		@Environment(\.dismiss) var dismiss
		
		@Query(filter: #Predicate<StatModel> { stat in
				stat.difficulty == "Easy"
		})
		private var difficultyStat: [StatModel]
		
		@State private var showHome = false
		var selectedDifficulty: String
		var currentGame: GameplayModel
		
    var body: some View {
				
				@Bindable var viewStates = viewStates

				Button(action: {
						viewStates.showGameplay = false
						viewStates.showEndRound = false
				}, label: {
						Text("play Again")
				})
				.onAppear {
						if difficultyStat.count == 1 {
								let stat = difficultyStat[0]
								stat.gamesPlayed += 1
								stat.currentStreak += 1
						} else {
								print("Error: Returned more than 1 stat difficulty")
						}
				}
    }
}

