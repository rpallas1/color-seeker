//
//  ColorSleuthApp.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData
import TelemetryDeck

@main
struct ColorSleuthApp: App {
		
		@State var viewStates = GlobalStates()
		@State private var settings = Settings()
		
		init() {
				let config = TelemetryDeck.Config(appID: "81C31ED3-4AB5-4765-BE71-9345960BB4DA")
				TelemetryDeck.initialize(config: config)
		}
		
    var body: some Scene {
        WindowGroup {
            MainView()
								.environment(viewStates)
								.environment(settings)
								.modelContainer(for: [StatModel.self])
								.preferredColorScheme(settings.colorScheme.colorScheme)
        }
    }
}
