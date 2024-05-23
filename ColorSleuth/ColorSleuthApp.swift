//
//  ColorSleuthApp.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

@main
struct ColorSleuthApp: App {
		
		@State var viewStates = GlobalStates()
		@State private var settings = Settings()
		
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
