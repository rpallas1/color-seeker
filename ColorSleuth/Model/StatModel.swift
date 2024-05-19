//
//  Stat.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftData

@Model
class StatModel {
		
		@Attribute(.unique) var difficulty: String
		@Attribute(.unique) var position: Int
		var gamesPlayed: Int = 0
		var gamesStarted: Int = 0
		var gamesFailed: Int = 0
		var gamesFinished: Int = 0
		var correctTaps: Int = 0
		var totalTaps: Int = 0
		var currentStreak: Int = 0
		var bestStreak: Int = 0
		var totalTime: Int = 0
		var bestTime: Int = 0
		var averageTime: Int = 0
		var percentCorrect: Double = 0.0
		
		init(difficuly: String, position: Int) {
				self.difficulty = difficuly
				self.position = position
		}
}

extension ModelContext {
		var sqliteCommand: String {
				if let url = container.configurations.first?.url.path(percentEncoded: false) {
						"sqlite3 \"\(url)\""
				} else {
						"No SQLite database found."
				}
		}
}


