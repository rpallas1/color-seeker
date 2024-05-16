//
//  StatsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
		
		@Environment(GlobalStates.self) var viewStates
//		@Query private var stats: [Stat]
		
		@State private var showSettings = false
		
		var body: some View {NavigationStack {
				
				@Bindable var viewStates = viewStates
				
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
										StatCategory(difficulty: "Overall", gamesPlayed: 450,
																 percentCorrect: 97, longestStreak: 203,
																 currentStreak: 1, bestTime: "00:23", averageTime: "01:01")
										StatCategory(difficulty: "Easy", gamesPlayed: 196,
																 percentCorrect: 100, longestStreak: 196,
																 currentStreak: 196, bestTime: "00:23", averageTime: "00:45")
										StatCategory(difficulty: "Medium", gamesPlayed: 88,
																 percentCorrect: 98, longestStreak: 65,
																 currentStreak: 23, bestTime: "00:45", averageTime: "01:10")
										StatCategory(difficulty: "Hard", gamesPlayed: 56,
																 percentCorrect: 99, longestStreak: 55,
																 currentStreak: 1, bestTime: "01:44", averageTime: "02:12")
										StatCategory(difficulty: "Extreme", gamesPlayed: 11,
																 percentCorrect: 85, longestStreak: 9,
																 currentStreak: 5, bestTime: "02:16", averageTime: "03:01")
										StatCategory(difficulty: "Survival", gamesPlayed: 0,
																 percentCorrect: 0, longestStreak: 0,
																 currentStreak: 0, bestTime: "-", averageTime: "-")
								}
								.scrollTargetLayout()
						}
						.scrollIndicators(.hidden)
						.contentMargins(.horizontal, 16)
						.scrollTargetBehavior(.viewAligned)
				}
				.navigationTitle("Stats")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
						ToolbarItem {
								Button(action: {
										showSettings.toggle()
								}, label: {
										Image(systemName: "gear")
												.foregroundStyle(Color("Primary Black"))
								})
						}
				}
		}
		.sheet(isPresented: $showSettings, content: {
				SettingsView()
						.presentationDragIndicator(.visible)
		})
				
		}
}

//#Preview {
//		StatsView()
//}
