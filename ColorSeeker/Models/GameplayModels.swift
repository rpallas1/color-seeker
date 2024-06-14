//
//  GameplayModel.swift
//  ColorSeeker
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
		var percentNeeded: Double = 85
		var totalRounds: Int = 20
		var gridSize: GridSize = .small
		
		var tapResults: [Bool?] = Array(repeating: nil, count: 20)
		
		func handleCorrectTap() {
				if let index = tapResults.firstIndex(of: nil) {
						tapResults[index] = true
				}
		}
		
		func handleIncorrectTap() {
				if let index = tapResults.firstIndex(of: nil) {
						tapResults[index] = false
				}
		}
		
		func resetProperties() {
				self.score = 0
				self.totalTaps = 0
				self.totalRounds = 20
				self.tapResults = Array(repeating: nil, count: 20)
		}
}

class SquareObject {
		
		var color: Color
		var isAnswer: Bool
		var dimensions: CGFloat
		var sqrtSize: Int
		var cornerRadius: CGFloat
		
		init(color: Color, isAnswer: Bool, size: CGFloat, sqrtSize: Int, cornerRadius: CGFloat) {
				self.color = color
				self.isAnswer = isAnswer
				self.dimensions = size
				self.sqrtSize = sqrtSize
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
