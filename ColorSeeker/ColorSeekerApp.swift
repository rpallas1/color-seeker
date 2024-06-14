//
//  ColorSeekerApp.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData
import TipKit
import TelemetryDeck

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
				
				let config = TelemetryDeck.Config(appID: "81C31ED3-4AB5-4765-BE71-9345960BB4DA")
				TelemetryDeck.initialize(config: config)
		}
		
    var body: some Scene {
        WindowGroup {
						ContentView()
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
