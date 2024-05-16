//
//  ColorSleuthApp.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

@main
struct ColorSleuthApp: App {
		
		@State var viewStates = GlobalStates()
		
    var body: some Scene {
        WindowGroup {
            MainView()
								.environment(viewStates)
        }
    }
}
