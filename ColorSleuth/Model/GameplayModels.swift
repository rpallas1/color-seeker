//
//  GameplayModel.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation
import SwiftUI

class GameplayModel {
		
		var difficulty: Difficulty = .easy
		var score: Int = 0
		var totalTaps: Int = 0
		var wonRound: Bool = false
		var elapsedTimeString: String = ""
		var elapsedTime: TimeInterval = 0
		var percentCorrect: Int = 0
		var totalRounds: Int = 3
		var gridSize: GridSize = .small
}

class SquareObject {
		
		var color: Color
		var isAnswer: Bool
		var size: CGFloat
		var cornerRadius: CGFloat
		
		init(color: Color, isAnswer: Bool, size: CGFloat, cornerRadius: CGFloat) {
				self.color = color
				self.isAnswer = isAnswer
				self.size = size
				self.cornerRadius = cornerRadius
		}
}

enum Difficulty: String {
		case easy = "Easy"
		case medium = "Medium"
		case hard = "Hard"
		case extreme = "Extreme"
		case survival = "Survival"
}

enum GridSize: Int {
		case small = 2
		case medium = 3
		case large = 4
}
