//
//  UpdateStats.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation
import SwiftUI
import SwiftData

struct StatHelper {

		
		

}

struct CalcStats {
		
		func percentCorrect(score: Int) -> Int {
				return (score / 1) * 100
		}
		
		func didPassRound(score: Int) -> Bool {
				if score == 0 {
						return false
				} else {
						return true
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
}
