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
				
				// TODO: Randomize for when on survival
				let gridSize = currentGame.gridSize.rawValue * currentGame.gridSize.rawValue
				let randIndex = Int.random(in: 0..<gridSize)
				let rgbColor = setRandomColor()
				let randColor: Color = buildColor(colorValues: rgbColor)
				let adjustedColor: Color = setAdjustedColor(color: rgbColor, difficulty: currentGame.difficulty)
				
				for i in 0..<gridSize {
						gridLayout.append(assignSquareValues(gridSize: gridSize, currentIndex: i, randIndex: randIndex, randColor: randColor, adjustedColor: adjustedColor))
				}
				return gridLayout
		}
		
		func assignSquareValues(gridSize: Int, currentIndex: Int, randIndex: Int, randColor: Color, adjustedColor: Color) -> SquareObject {
				var size: CGFloat {
						switch gridSize {
						case 4:
								return 136
						case 9:
								return 100
						default:
								return 85
						}
				}
				
				var radius: CGFloat {
						switch gridSize {
						case 4:
								return 12
						case 9:
								return 10
						default:
								return 6
						}
				}
				
				if currentIndex == randIndex {
						return SquareObject(color: adjustedColor, isAnswer: true, size: size, cornerRadius: radius)
				} else {
						return SquareObject(color: randColor, isAnswer: false, size: size, cornerRadius: radius)
				}
		}
		
		func setRandomColor() -> rgbColor {
				let red: Double = Double.random(in: 0...255)
				let green: Double = Double.random(in: 0...255)
				let blue: Double = Double.random(in: 0...255)
				
				return rgbColor(red: red, green: green, blue: blue)
		}
		
		func setAdjustedColor(color: rgbColor, difficulty: Difficulty) -> Color {
				var increaseValue: Bool {
						if Int.random(in: 0...1) == 0 {
								return true
						} else {
								return false
						}
				}
				
				var adjustedBy: Double {
						switch difficulty {
						case .easy:
								return 70
						case .medium:
								return 52
						case .hard:
								return 30
						case .extreme:
								return 14
						case .survival:
								// TODO: Return random number from these 4 options
								return 14
						}
				}
				
				var red = color.red
				var green = color.green
				var blue = color.blue
				
				if increaseValue {
						red += adjustedBy
						green += adjustedBy
						blue += adjustedBy
				} else {
						red -= adjustedBy
						green -= adjustedBy
						blue -= adjustedBy
				}
				
				return buildColor(colorValues: rgbColor(red: red, green: green, blue: blue))
		}
		
		private func buildColor(colorValues: rgbColor) -> Color {
				return Color(red: colorValues.red/255, green: colorValues.green/255, blue: colorValues.blue/255)
		}
}

struct rgbColor {
		var red: Double
		var green: Double
		var blue: Double
}
