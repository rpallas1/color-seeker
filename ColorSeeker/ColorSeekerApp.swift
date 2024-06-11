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
				
		@State var viewStates = GlobalStates()
		@State private var settings = Settings()
		@AppStorage("needsOnboarding") var needsOnboarding: Bool = true
		
    var body: some Scene {
        WindowGroup {
						MainView()
								.environment(viewStates)
								.environment(settings)
								.modelContainer(for: [StatModel.self, AchievementModel.self, GroupModel.self, Goal.self])
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
    }
}
