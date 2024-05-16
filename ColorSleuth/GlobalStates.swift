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
		var darkMode = false
		var haptics = false
}
