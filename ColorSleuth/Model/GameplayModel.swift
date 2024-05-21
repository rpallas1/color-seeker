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
		var time: Int = 0
		var percentCorrect: Int = 0
		// Start and end time or timer variable
}

enum Difficulty: String {
		case easy = "Easy"
		case medium = "Medium"
		case hard = "Hard"
		case extreme = "Extreme"
		case survival = "Survival"
}
