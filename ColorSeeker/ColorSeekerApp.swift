//
//  ColorSleuthApp.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData
import TipKit

@main
struct ColorSeekerApp: App {
				
		let modelContainer: ModelContainer
		@State var viewStates = GlobalStates()
		@State private var settings = Settings()
		@AppStorage("needsOnboarding") var needsOnboarding: Bool = true
		
		init() {
				let schema = Schema([StatModel.self, AchievementModel.self, GroupModel.self, Goal.self])
				do {
						modelContainer = try ModelContainer(for: schema)
				} catch let error {
						fatalError("Cannot set up modelContainer: \(error.localizedDescription)")
				}
		}
		
    var body: some Scene {
        WindowGroup {
						MainView()
								.environment(viewStates)
								.environment(settings)
								.preferredColorScheme(settings.colorScheme.colorScheme)
								.fullScreenCover(isPresented: $needsOnboarding, onDismiss: {
										needsOnboarding = false
								}, content: {
										HowToPlayView(throughSettings: false)
								})
								.task {
										try? Tips.configure([
												.displayFrequency(.immediate),
												.datastoreLocation(.applicationDefault)
										])
								}
        }
				.modelContainer(modelContainer)
    }
}
