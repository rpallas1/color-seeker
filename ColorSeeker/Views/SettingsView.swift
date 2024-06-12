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
		
		// Define state property for the context to be passed outside of a view
		@State private var defaultData: DefaultDataHelper?
		
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
						.onAppear {
								defaultData = DefaultDataHelper(context: context)
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
										
										defaultData!.initStats()
										defaultData!.initAchievemnets()
								}
						}
				}
		}
		
		private func disableRest(stats: [StatModel]) -> Bool {
				if stats[0].gamesPlayed == 0 && stats[5].gamesPlayed == 0 {
						return true
				}
				
				return false
		}
}
