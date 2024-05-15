//
//  AchievementsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementsView: View {
		
		@State private var showSettings = false
		@State private var currentPage = 0
		
		var body: some View {
				NavigationStack {
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
						
						ScrollView {
								// List of achievements
								VStack {
										AchievementSet()
										AchievementSet()
										AchievementSet()
										AchievementSet()
								}
						}
						.padding(.horizontal)
						.scrollIndicators(.hidden)
						.sheet(isPresented: $showSettings, content: {
								SettingsView()
						})
						.navigationTitle("Achievements")
						.navigationBarTitleDisplayMode(.inline)
						.toolbar {
								ToolbarItem {
										Button(action: {
												showSettings = true
										}, label: {
												Image(systemName: "gear")
														.foregroundStyle(.black)
										})
								}
						}
						
				}
		}
}

#Preview {
		AchievementsView()
}
