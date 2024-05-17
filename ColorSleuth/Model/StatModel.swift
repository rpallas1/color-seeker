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
		
		var difficulty: String
		var rawStats: [RawStat]
		
		init(difficulty: String, rawStats: [RawStat]) {
				self.difficulty = difficulty
				self.rawStats = rawStats
		}
}

@Model
class RawStat {
		
		var gamesPlayed: Int
		var gamesStarted: Int
		var gamesFailed: Int
		var gamesFinished: Int
		var correctTaps: Int
		var currentStreak: Int
		var bestStreak: Int
		var totalTime: Int
		var bestTime: Int
		var averageTime: Int
		var percentCorrect: Double
		
		init(gamesPlayed: Int, gamesStarted: Int, gamesFailed: Int, gamesFinished: Int, correctTaps: Int, currentStreak: Int, bestStreak: Int, totalTime: Int, bestTime: Int, averageTime: Int, percentCorrect: Double) {
				self.gamesPlayed = gamesPlayed
				self.gamesStarted = gamesStarted
				self.gamesFailed = gamesFailed
				self.gamesFinished = gamesFinished
				self.correctTaps = correctTaps
				self.currentStreak = currentStreak
				self.bestStreak = bestStreak
				self.totalTime = totalTime
				self.bestTime = bestTime
				self.averageTime = averageTime
				self.percentCorrect = percentCorrect
		}

}

struct calcStats {
		
		func calcAverageTime(totalTime: Int, gamesPlayed: Int) -> Int {
				
				return totalTime / gamesPlayed
		}
		
		func calcBestStreak() {
				
		}
		
		func calcBestTime() {
				
		}
		
		func calcPercentCorrect() {
				
		}
}

