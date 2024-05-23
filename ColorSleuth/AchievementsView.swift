//
//  AchievementsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementsView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		@State private var showSettings = false
		
		var body: some View {
								
				NavigationStack {
						VStack {
								ScrollView(.horizontal) {
										// List of difficulties
										HStack (spacing: 36) {
												Text("Overall")
														.foregroundStyle(.cyan)
														.bold()
												Text("Easy")
												Text("Medium")
												Text("Hard")
												Text("Extreme")
												Text("Survival")
										}
										.padding([.top, .horizontal])
								}
								.scrollIndicators(.hidden)
								
								ScrollView(.horizontal) {
										LazyHStack (spacing: 50) {
												AchievementCategoryView(difficulty: "Overall")
												AchievementCategoryView(difficulty: "Easy")
												AchievementCategoryView(difficulty: "Medium")
												AchievementCategoryView(difficulty: "Hard")
												AchievementCategoryView(difficulty: "Extreme")
												AchievementCategoryView(difficulty: "Survival")
										}
										.scrollTargetLayout()
								}
								.scrollIndicators(.hidden)
								.contentMargins(.horizontal, 16)
								.scrollTargetBehavior(.viewAligned)
						}
						.navigationTitle("Achievements")
						.navigationBarTitleDisplayMode(.inline)
				}
		}
}
