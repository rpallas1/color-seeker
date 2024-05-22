//
//  GameplayModel.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation

class GameplayModel {
		
		var difficulty: Difficulty = .easy
		var score: Int = 0
		var wonRound: Bool = false
		var elapsedTimeString: String = ""
		var elapsedTime: TimeInterval = 0
		var percentCorrect: Int = 0
		var totalRounds: Int = 1
}

enum Difficulty: String {
		case easy = "Easy"
		case medium = "Medium"
		case hard = "Hard"
		case extreme = "Extreme"
		case survival = "Survival"
}
