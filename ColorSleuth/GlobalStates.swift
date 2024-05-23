//
//  ViewStates.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftUI

@Observable
class GlobalStates {
		
		// View States
		var showPause = false
		var showGameplay = false
		var showEndRound = false
		
		// Settings
		var haptics = false
}

@Observable
class Settings {
		var haptics = false
		var colorScheme: ColorSchemeOption {
				didSet {
						saveColorScheme()
				}
		}
		
		enum ColorSchemeOption: String, CaseIterable, Identifiable {
				case light
				case dark
				case system
				
				var id: String { self.rawValue }
				
				var colorScheme: ColorScheme? {
						switch self {
						case .light:
								return .light
						case .dark:
								return .dark
						case .system:
								return nil
						}
				}
		}
		
		init() {
				self.colorScheme = Settings.loadColorScheme()
		}
		
		private func saveColorScheme() {
				UserDefaults.standard.set(colorScheme.rawValue, forKey: "selectedColorScheme")
		}
		
		private static func loadColorScheme() -> ColorSchemeOption {
				if let savedScheme = UserDefaults.standard.string(forKey: "selectedColorScheme"),
					 let colorScheme = ColorSchemeOption(rawValue: savedScheme) {
						return colorScheme
				}
				return .system
		}
}
