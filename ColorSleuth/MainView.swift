//
//  ContentView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
		
		@Environment(\.modelContext) var context
		@Query private var allStats: [StatModel]
		
		private var statHelper = StatHelper()
		
    var body: some View {
				TabView {
						HomeView()
								.tabItem {
										Label("Home", systemImage: "house")
								}
						
						StatsView()
								.tabItem {
										Label("Stats", systemImage: "square.stack.3d.up")
								}
						
						AchievementsView()
								.tabItem {
										Label("Achievements", systemImage: "trophy")
								}
				}
				.onAppear {
						if allStats.count == 0 {
								initStats()
								print(context.sqliteCommand)
						} else {
								print(allStats.count)
								print(context.sqliteCommand)
						}
				}
    }
		
		func initStats() {
				context.insert(StatModel(difficuly: "Overall", position: 0))
				context.insert(StatModel(difficuly: "Easy", position: 1))
				context.insert(StatModel(difficuly: "Medium", position: 2))
				context.insert(StatModel(difficuly: "Hard", position: 3))
				context.insert(StatModel(difficuly: "Extreme", position: 4))
				context.insert(StatModel(difficuly: "Survival", position: 5))
		}
}
