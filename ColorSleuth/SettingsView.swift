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
		@Query(sort: \StatModel.position)
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
																HowToPlayView()
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
												.foregroundStyle(sortedStats[0].gamesPlayed == 0 ? .gray : .red)
												.disabled(sortedStats[0].gamesPlayed == 0)
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
								Button("Delete Game Data", role: .destructive) {
										
										do {
												try context.delete(model: StatModel.self)
										} catch {
												print("Failed to delete all stats.")
										}
										
										initStats()
								}
						}
				}
		}
		
		private func initStats() {
				context.insert(StatModel(difficuly: "Overall", position: 0))
				context.insert(StatModel(difficuly: "Easy", position: 1))
				context.insert(StatModel(difficuly: "Medium", position: 2))
				context.insert(StatModel(difficuly: "Hard", position: 3))
				context.insert(StatModel(difficuly: "Extreme", position: 4))
				context.insert(StatModel(difficuly: "Survival", position: 5))
		}
}
