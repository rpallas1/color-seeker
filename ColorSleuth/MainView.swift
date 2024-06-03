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
		@Environment(Settings.self) var settings
		
		@Query private var allStats: [StatModel]
		@Query private var allAchievements: [AchievementModel]
		@State var selection = Tabs.home
		@State private var showSettings = false

    var body: some View {
				NavigationStack {
						TabView(selection: $selection) {
								HomeView()
										.tabItem {
												Label("Home", systemImage: "house")
										}
										.tag(Tabs.home)
								
								StatsView()
										.tabItem {
												Label("Stats", systemImage: "square.stack.3d.up")
										}
										.tag(Tabs.stats)
								
								AchievementsView()
										.tabItem {
												Label("Achievements", systemImage: "trophy")
										}
										.tag(Tabs.achievements)
						}
						.navigationTitle(selection.rawValue == "home" ? "" : selection.rawValue.capitalized)
						.navigationBarTitleDisplayMode(.inline)
						.navigationBarBackButtonHidden()
						.onAppear {
								if allStats.count == 0 && allAchievements.count == 0 {
										initStats()
										initAchievemnets()
//										print(context.sqliteCommand)
								} else {
//										print(context.sqliteCommand)
								}
						}
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
				})

    }
		
		func initStats() {
				context.insert(StatModel(difficuly: "Overall", index: 0))
				context.insert(StatModel(difficuly: "Easy", index: 1))
				context.insert(StatModel(difficuly: "Medium", index: 2))
				context.insert(StatModel(difficuly: "Hard", index: 3))
				context.insert(StatModel(difficuly: "Extreme", index: 4))
				context.insert(StatModel(difficuly: "Survival", index: 5))
		}
		
		func initAchievemnets() {
				context.insert(AchievementModel(difficulty: "Overall",
																				index: 0,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Perfect Games",
																											 index: 1,
																											 descriptionString: "_ Perfect Games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 750, isComplete: false),
																															 Goal(value: 1500, isComplete: false)]),
																								 GroupModel(name: "Streaks",
																											 index: 2,
																											 descriptionString: "Streak of _",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false)]),
																								 GroupModel(name: "Times",
																											 index: 3,
																											 descriptionString: "Complete _ games under - seconds",
																											 progress: 0,
																											 goals: [Goal(value: 750, time: 35, isComplete: false),
																															 Goal(value: 5000, time: 35, isComplete: false),
																															 Goal(value: 1000, time: 20, isComplete: false),
																															 Goal(value: 2500, time: 20, isComplete: false),
																															 Goal(value: 500, time: 10, isComplete: false),
																															 Goal(value: 2500, time: 10, isComplete: false)])]))
				context.insert(AchievementModel(difficulty: "Easy",
																				index: 1,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Perfect Games",
																											 index: 1,
																											 descriptionString: "_ Perfect Games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 750, isComplete: false),
																															 Goal(value: 1500, isComplete: false)]),
																								 GroupModel(name: "Streaks",
																											 index: 2,
																											 descriptionString: "Streak of _",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false)]),
																								 GroupModel(name: "Times",
																											 index: 3,
																											 descriptionString: "Complete _ games under - seconds",
																											 progress: 0,
																											 goals: [Goal(value: 750, time: 35, isComplete: false),
																															 Goal(value: 5000, time: 35, isComplete: false),
																															 Goal(value: 1000, time: 20, isComplete: false),
																															 Goal(value: 2500, time: 20, isComplete: false),
																															 Goal(value: 500, time: 10, isComplete: false),
																															 Goal(value: 2500, time: 10, isComplete: false)])]))
				context.insert(AchievementModel(difficulty: "Medium",
																				index: 2,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Perfect Games",
																											 index: 1,
																											 descriptionString: "_ Perfect Games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 750, isComplete: false),
																															 Goal(value: 1500, isComplete: false)]),
																								 GroupModel(name: "Streaks",
																											 index: 2,
																											 descriptionString: "Streak of _",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false)]),
																								 GroupModel(name: "Times",
																											 index: 3,
																											 descriptionString: "Complete _ games under - seconds",
																											 progress: 0,
																											 goals: [Goal(value: 750, time: 35, isComplete: false),
																															 Goal(value: 5000, time: 35, isComplete: false),
																															 Goal(value: 1000, time: 20, isComplete: false),
																															 Goal(value: 2500, time: 20, isComplete: false),
																															 Goal(value: 500, time: 10, isComplete: false),
																															 Goal(value: 2500, time: 10, isComplete: false)])]))
				context.insert(AchievementModel(difficulty: "Hard",
																				index: 3,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Perfect Games",
																											 index: 1,
																											 descriptionString: "_ Perfect Games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 750, isComplete: false),
																															 Goal(value: 1500, isComplete: false)]),
																								 GroupModel(name: "Streaks",
																											 index: 2,
																											 descriptionString: "Streak of _",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false)]),
																								 GroupModel(name: "Times",
																											 index: 3,
																											 descriptionString: "Complete _ games under - seconds",
																											 progress: 0,
																											 goals: [Goal(value: 750, time: 35, isComplete: false),
																															 Goal(value: 5000, time: 35, isComplete: false),
																															 Goal(value: 1000, time: 20, isComplete: false),
																															 Goal(value: 2500, time: 20, isComplete: false),
																															 Goal(value: 500, time: 10, isComplete: false),
																															 Goal(value: 2500, time: 10, isComplete: false)])]))
				context.insert(AchievementModel(difficulty: "Extreme",
																				index: 4,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Perfect Games",
																											 index: 1,
																											 descriptionString: "_ Perfect Games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 750, isComplete: false),
																															 Goal(value: 1500, isComplete: false)]),
																								 GroupModel(name: "Streaks",
																											 index: 2,
																											 descriptionString: "Streak of _",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 50, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false)]),
																								 GroupModel(name: "Times",
																											 index: 3,
																											 descriptionString: "Complete _ games under - seconds",
																											 progress: 0,
																											 goals: [Goal(value: 750, time: 35, isComplete: false),
																															 Goal(value: 5000, time: 35, isComplete: false),
																															 Goal(value: 1000, time: 20, isComplete: false),
																															 Goal(value: 2500, time: 20, isComplete: false),
																															 Goal(value: 500, time: 10, isComplete: false),
																															 Goal(value: 2500, time: 10, isComplete: false)])]))
				context.insert(AchievementModel(difficulty: "Survival",
																				index: 5,
																				groups: [GroupModel(name: "Games Played",
																											 index: 0,
																											 descriptionString: "Play _ games",
																											 progress: 0,
																											 goals: [Goal(value: 25, isComplete: false),
																															 Goal(value: 100, isComplete: false),
																															 Goal(value: 250, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 1000, isComplete: false),
																															 Goal(value: 5000, isComplete: false)]),
																								 GroupModel(name: "Scores",
																											 index: 3,
																											 descriptionString: "Score of _",
																											 progress: 0,
																											 goals: [Goal(value: 100, isComplete: false),
																															 Goal(value: 200, isComplete: false),
																															 Goal(value: 300, isComplete: false),
																															 Goal(value: 500, isComplete: false),
																															 Goal(value: 800, isComplete: false),
																															 Goal(value: 1500, isComplete: false)])]))
		}
}

enum Tabs: String {
		case home
		case stats
		case achievements
}
