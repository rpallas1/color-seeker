//
//  AchievementCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementCategoryView: View {
		
		var difficulty: String
		
    var body: some View {
				ScrollView {
						// List of achievements
						VStack {
								AchievementGroupView(section: "Games Played", description1: "Play 25\nGames", 
																 description2: "Play 100\nGames", description3: "Play 250\nGames",
																 description4: "Play 500\nGames", description5: "Play 1000\nGames",
																 description6: "Play 5000\nGames")
								Divider()
										.padding(.leading)
								AchievementGroupView(section: "Perfect Games", description1: "25 Perfect\nGames",
																 description2: "50 Perfect\nGames", description3: "100 Perfect\nGames",
																 description4: "500 Perfect\nGames", description5: "750 Perfect\nGames",
																 description6: "1500 Perfect\nGames")
								Divider()
										.padding(.leading)
								AchievementGroupView(section: "Streaks", description1: "Streak\nof 25",
																 description2: "Streak\nof 50", description3: "Streak\nof 100",
																 description4: "Streak\nof 200", description5: "Streak\nof 500",
																 description6: "Streak\nof 1000")
								Divider()
										.padding(.leading)
								AchievementGroupView(section: "Total Times", description1: "Complete 750\nrounds under\n35 seconds",
																 description2: "Complete 5000\nrounds under\n35 seconds", description3: "Complete 1000\nrounds under\n20 seconds",
																 description4: "Complete 2500\nrounds under\n20 seconds", description5: "Complete 500\nrounds under\n10 seconds",
																 description6: "Complete 2500\nrounds under\n10 seconds")
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}
