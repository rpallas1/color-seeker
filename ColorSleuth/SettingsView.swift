//
//  SettingsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
		
		@Environment(\.dismiss) private var dismiss
		@Environment(Settings.self) var settings
		@Environment(\.modelContext) private var context
		
		@Query private var allStats: [StatModel]
		@Query(sort: \StatModel.index)
		private var sortedStats: [StatModel]
		
		@State private var showConfirmation = false
		
		var body: some View {
				
				@Bindable var settings = settings
				
				NavigationStack {
						VStack {
								Form {
										Section {
												HStack {
														Text("How to Play")
														Spacer()
														NavigationLink {
																HowToPlayView(throughSettings: true)
														} label: {}
												}
												
												Picker("Color Scheme", selection: $settings.colorScheme) {
														ForEach(Settings.ColorSchemeOption.allCases) { option in
																Text(option.rawValue.capitalized)
																		.tag(option)
														}
												}
												.pickerStyle(.menu)
												
												Toggle("Haptics", isOn: $settings.hapticsEnabled)
												
										}
										
										Section {
												Button("Reset Game Data") {
														showConfirmation = true
												}
												.foregroundStyle(disableRest(stats: sortedStats) ? .gray : .red)
												.disabled(disableRest(stats: sortedStats))
										}
								}
						}
						.navigationTitle("Settings")
						.navigationBarTitleDisplayMode(.inline)
						.preferredColorScheme(settings.colorScheme.colorScheme)
						.toolbar {
								Button(action: {
										dismiss()
								}, label: {
										Text("Done")
												.bold()
								})
						}
						.confirmationDialog("Reseting data includes all stats and achievements. Are you sure you want to reset all game data? ", isPresented: $showConfirmation, titleVisibility: .visible) {
								Button("Reset Game Data", role: .destructive) {
										
										do {
												try context.delete(model: StatModel.self)
										} catch {
												print("Failed to delete all stats.")
										}
										
										do {
												try context.delete(model: AchievementModel.self)
										} catch {
												print("Failed to delete all achievements.")
										}
										
										initStats()
										initAchievemnets()
								}
						}
				}
		}
		
		private func initStats() {
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
		
		private func disableRest(stats: [StatModel]) -> Bool {
				if stats[0].gamesPlayed == 0 && stats[5].gamesPlayed == 0 {
						return true
				}
				
				return false
		}
}
