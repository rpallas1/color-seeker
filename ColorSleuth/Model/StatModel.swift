//
//  Stat.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import Foundation
import SwiftData

@Model
class StatModel: Identifiable {
		
		@Attribute(.unique) var difficulty: String
		@Attribute(.unique) var position: Int
		var gamesPlayed: Int = 0
		var gamesWon: Int = 0
		var perfectGames: Int = 0
		var gamesStarted: Int = 0
		var gamesFailed: Int = 0
		var gamesFinished: Int = 0
		var correctTaps: Int = 0
		var totalTaps: Int = 0
		var currentStreak: Int = 0
		var bestStreak: Int = 0
		var totalTime: TimeInterval = 0
		var bestTime: Double = 0
		var bestTimeString: String = ""
		var averageTime: Double = 0
		var averageTimeString: String = ""
		var percentCorrect: Int = 0
		
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



