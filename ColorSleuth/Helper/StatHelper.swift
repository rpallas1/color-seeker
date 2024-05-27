//
//  UpdateStats.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation
import SwiftUI
import SwiftData

struct CalcStats {
		
		func percentCorrect(currentGame: GameplayModel) -> Double {
				return (Double(currentGame.score) / Double(currentGame.totalRounds)) * 100
		}
		
		func accuracy(stat: StatModel) -> Double {
				return (Double(stat.correctTaps) / Double(stat.totalTaps)) * 100
		}
		
		func didPassRound(currentGame: GameplayModel) -> Bool {
				if percentCorrect(currentGame: currentGame) >= currentGame.percentNeeded {
						return true
				} else {
						return false
				}
		}
		
		func bestStreak(currentStreak: Int, bestStreak: Int) -> Int {
				if currentStreak > bestStreak {
						return currentStreak
				} else {
						return bestStreak
				}
		}
		
		func highScore(currentScore: Int, highScore: Int) -> Int {
				if currentScore > highScore {
						return currentScore
				} else {
						return highScore
				}
		}
		
		func averageScore(correctTaps: Int, gamesPlayed: Int) -> Int{
				return correctTaps / gamesPlayed
		}
		
		func isPerfectRound(currentGame: GameplayModel) -> Bool {
				if currentGame.score == currentGame.totalRounds {
						return true
				} else {
						return false
				}
		}
		
		func winRate(stat: StatModel) -> Double {
				return (Double(stat.gamesWon) / Double(stat.gamesPlayed)) * 100
		}
		
		func bestTime(currentTime: TimeInterval, bestTime: Double) -> Double {
				if Double(currentTime) < 1 {
						return 1
				}
				else if Double(currentTime) < bestTime || bestTime == 0 {
						return Double(currentTime)
				} 
				else {
						return bestTime
				}
		}
		
		func currentTimeTapRatio(currentGame: GameplayModel) -> Double {
				return Double(currentGame.elapsedTime) / Double(currentGame.score)
		}
		
		func averageTime(gamesPlayed: Int, totalTime: TimeInterval) -> Double {
				return Double(totalTime) / Double(gamesPlayed)
		}
		
		func avgTimeTapRatio(stats: StatModel) -> Double {
				let totalTime = stats.totalTime
				let correctTaps = stats.correctTaps
				
				return Double(totalTime) / Double(correctTaps)
		}
}
