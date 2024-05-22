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
		
		func percentCorrect(currentGame: GameplayModel) -> Int {
				return Int((Double(currentGame.score) / Double(currentGame.totalRounds)) * 100)
		}
		
		func didPassRound(currentGame: GameplayModel) -> Bool {
				if currentGame.score > Int(Double(currentGame.totalRounds) / 2) {
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
		
		func resetStreak (currentGame: GameplayModel) -> Bool {
				if currentGame.score < 1 {
						return true
				} else {
						return false
				}
		}
		
		func isPerfectRound(currentGame: GameplayModel) -> Bool {
				if currentGame.score == currentGame.totalRounds {
						return true
				} else {
						return false
				}
		}
		
		func winRate(stat: StatModel) -> Int {
				return Int((Double(stat.gamesWon) / Double(stat.gamesPlayed)) * 100)
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
		
		func averageTime(gamesPlayed: Int, totalTime: TimeInterval) -> Double {
				return Double(totalTime) / Double(gamesPlayed)
		}
		
		func formatTime(elapsedTime: Double) -> String {
				let minutes = Int(elapsedTime) / 60
				let seconds = Int(elapsedTime) % 60
				return String(format: "%02d:%02d", minutes, seconds)
		}
}
