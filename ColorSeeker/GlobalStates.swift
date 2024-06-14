//
//  ViewStates.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftUI

@Observable
class GlobalStates {
		var showPause = false
		var showGameplay = false
		var showEndRound = false
		var showFullDescription = false
		var sentAnalytics = false
		var deviceColorScheme: ColorScheme? = nil
}

@Observable
class Settings {
		var colorScheme: ColorSchemeOption {
				didSet {
						saveColorScheme()
				}
		}
		
		var hapticsEnabled: Bool {
				didSet {
						saveHapticsEnabled()
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
				self.hapticsEnabled = Settings.loadHapticsEnabled()
		}
		
		func referenceColor(for scheme: ColorSchemeOption) -> Color {
				switch scheme {
				case .light:
						return .white
				case .dark:
						return .black
				case .system:
						return UITraitCollection.current.userInterfaceStyle == .dark ? .black : .white
				}
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
		
		private func saveHapticsEnabled() {
				UserDefaults.standard.set(hapticsEnabled, forKey: "hapticsEnabled")
		}
		
		private static func loadHapticsEnabled() -> Bool {
				if UserDefaults.standard.object(forKey: "hapticsEnabled") == nil {
						return true
				}
				return UserDefaults.standard.bool(forKey: "hapticsEnabled")
		}
}
