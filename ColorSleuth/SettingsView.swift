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
		@Environment(GlobalStates.self) var settings
		@Environment(\.modelContext) private var context
		
		@Query private var allStats: [StatModel]
		@State private var showConfirmation = false
		private var statHelper = StatHelper()
		
    var body: some View {
				
				@Bindable var settings = settings
				
				NavigationStack {
						VStack {
								Form {
										Section() {
												HStack {
														Text("How to Play")
														Spacer()
														NavigationLink {
																HowToPlayView()
														} label: {}
												}
												Toggle("Dark Mode", isOn: $settings.darkMode)
												Toggle("Haptics", isOn: $settings.haptics)
										}
										
										Section {
												Button("Reset Game Data") {
														showConfirmation = true
												}
												.foregroundStyle(.red)
										}
								}
						}
						.navigationTitle("Settings")
						.navigationBarTitleDisplayMode(.inline)
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
		
		func initStats() {
				context.insert(StatModel(difficuly: "Overall", position: 0))
				context.insert(StatModel(difficuly: "Easy", position: 1))
				context.insert(StatModel(difficuly: "Medium", position: 2))
				context.insert(StatModel(difficuly: "Hard", position: 3))
				context.insert(StatModel(difficuly: "Extreme", position: 4))
				context.insert(StatModel(difficuly: "Survival", position: 5))
		}
}
