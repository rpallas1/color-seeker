//
//  GameplayModel.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation
import SwiftData

@Model
class GameplayModel {
		
		var difficulty: Difficulty
		var score: Int = 0
		var wonRound: Bool = false
		// Start and end time or timer variable
		
		init(difficulty: Difficulty) {
				self.difficulty = .easy
		}
}

enum Difficulty: String {
		case easy = "Easy"
		case medium = "Medium"
		case hard = "Hard"
		case extreme = "Extreme"
		case survival = "Survival"
}
