//
//  GameHelper.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/22/24.
//

import Foundation
import SwiftData
import SwiftUI

struct GameHelper {
		
		func buildGrid(currentGame: GameplayModel) -> [SquareObject] {
				var gridLayout = [SquareObject]()
				let gridSize = currentGame.gridSize.rawValue * currentGame.gridSize.rawValue
				let randIndex = Int.random(in: 0..<gridSize)
				let randColor: Color = setRandomColor()
				let adjustedColor: Color = setAdjustedColor(color: randColor)
				
				for i in 0..<gridSize {
						gridLayout.append(assignSquareValues(gridSize: gridSize, currentIndex: i, randIndex: randIndex, randColor: randColor, adjustedColor: adjustedColor))
				}
				return gridLayout
		}
		
		func assignSquareValues(gridSize: Int, currentIndex: Int, randIndex: Int, randColor: Color, adjustedColor: Color) -> SquareObject {
				var size: CGFloat {
						if gridSize == 4 {
								return 136
						} else if gridSize == 9 {
								return 100
						} else {
								return 85
						}
				}
				
				var radius: CGFloat {
						if gridSize == 4 {
								return 12
						} else if gridSize == 9 {
								return 10
						} else {
								return 6
						}
				}
				
				if currentIndex == randIndex {
						return SquareObject(color: adjustedColor, isAnswer: true, size: size, cornerRadius: radius)
				} else {
						return SquareObject(color: randColor, isAnswer: false, size: size, cornerRadius: radius)
				}
		}
		
		func setRandomColor() -> Color {
				let red: Double = Double.random(in: 0...255)
				let green: Double = Double.random(in: 0...255)
				let blue: Double = Double.random(in: 0...255)
				
				return Color(red: red/255, green: green/255, blue: blue/255)
		}
		
		func setAdjustedColor(color: Color) -> Color {
				// Depends on the difficulty of how much to adjust (harder = smaller change, easy = larger change)
				return .blue
		}
}
