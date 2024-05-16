//
//  StatCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct StatCategory: View {
		
//		var stat: Stat = [Stat]
		var difficulty: String
		var gamesPlayed: Int
		var percentCorrect: Int
		var longestStreak: Int
		var currentStreak: Int
		var bestTime: String
		var averageTime: String
		
    var body: some View {
				ScrollView {
						// List of stats
						VStack (spacing: 28) {
								StatGroup(section: "Games", firstStatName: "Games Played", 
													firstStat: "\(String(gamesPlayed))", secondStatName: "Percent Correct",
													secondStat: "\(String(percentCorrect))%")
								StatGroup(section: "Streaks", firstStatName: "Longest Streak",
													firstStat: "\(String(longestStreak))", secondStatName: "Current Streak",
													secondStat: "\(String(currentStreak))")
								StatGroup(section: "Times", firstStatName: "Best Time",
													firstStat: bestTime, secondStatName: "Average Time",
													secondStat: averageTime)
								
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}
