//
//  Stat.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftData

@Model
class Stat {
		
		var difficulty = ""
		var bestTime: Int = 0
		var averageTime: Int = 0
		var longestStreak: Int = 0
		var currentStreak: Int = 0
		var percentCorrect: Int = 0
		var gamesPlayed: Int = 0
		
		init() {
				
		}
}

