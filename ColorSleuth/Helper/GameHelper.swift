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
		
		@Environment(Settings.self) var settings
		
		func buildGrid(currentGame: GameplayModel, colorScheme: Color) -> [SquareObject] {
				var gridLayout = [SquareObject]()
				
				let randSize: Int = Int.random(in: 2...4)
				let randGridSize = randSize * randSize
				let normalGridSize = currentGame.gridSize.rawValue * currentGame.gridSize.rawValue
				var gridSize: Int {
						if currentGame.difficulty == .survival {
								return randGridSize
						} else {
								return normalGridSize
						}
				}
				let randIndex = Int.random(in: 0..<gridSize)
				
				let rgbColor = setRandomColor(withMinimumContrastRatio: 4, referenceColor: colorScheme)
				let randColor: Color = buildColor(colorValues: rgbColor)
				let adjustedColor: Color = setAdjustedColor(color: rgbColor, difficulty: currentGame.difficulty)
				
				for i in 0..<gridSize {
						gridLayout.append(assignSquareValues(gridSize: gridSize, currentIndex: i, randIndex: randIndex, randColor: randColor, adjustedColor: adjustedColor))
				}
				return gridLayout
		}
		
		private func assignSquareValues(gridSize: Int, currentIndex: Int, randIndex: Int, randColor: Color, adjustedColor: Color) -> SquareObject {
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
				
				var sqrtSize: Int {
						switch gridSize {
						case 4:
								return 2
						case 9:
								return 3
						default:
								return 4
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
						return SquareObject(color: adjustedColor, isAnswer: true, size: size, sqrtSize: sqrtSize, cornerRadius: radius)
				} else {
						return SquareObject(color: randColor, isAnswer: false, size: size, sqrtSize: sqrtSize, cornerRadius: radius)
				}
		}
		
		private func setRandomColor(withMinimumContrastRatio minContrastRatio: CGFloat, referenceColor: Color) -> rgbColor {
				func luminance(for color: rgbColor) -> CGFloat {
						let r = CGFloat(color.red)
						let g = CGFloat(color.green)
						let b = CGFloat(color.blue)
						
						let rsRGB = r / 255.0
						let gsRGB = g / 255.0
						let bsRGB = b / 255.0
						
						let rLuminance = rsRGB <= 0.03928 ? rsRGB / 12.92 : pow((rsRGB + 0.055) / 1.055, 2.4)
						let gLuminance = gsRGB <= 0.03928 ? gsRGB / 12.92 : pow((gsRGB + 0.055) / 1.055, 2.4)
						let bLuminance = bsRGB <= 0.03928 ? bsRGB / 12.92 : pow((bsRGB + 0.055) / 1.055, 2.4)
						
						return 0.2126 * rLuminance + 0.7152 * gLuminance + 0.0722 * bLuminance
				}
				
				func contrastRatio(between color1: rgbColor, and color2: Color) -> CGFloat {
						let color2UIColor = UIColor(color2)
						let color2RGB = rgbColor(
								red: Double(color2UIColor.cgColor.components![0]) * 255.0,
								green: Double(color2UIColor.cgColor.components![1]) * 255.0,
								blue: Double(color2UIColor.cgColor.components![2]) * 255.0
						)
						
						let lum1 = luminance(for: color1) + 0.05
						let lum2 = luminance(for: color2RGB) + 0.05
						return max(lum1, lum2) / min(lum1, lum2)
				}
				
				func generateRandomColor() -> rgbColor {
						return rgbColor(
								red: Double(arc4random() % 256),
								green: Double(arc4random() % 256),
								blue: Double(arc4random() % 256)
						)
				}
				
				var randomColor = generateRandomColor()
				while contrastRatio(between: randomColor, and: referenceColor) < minContrastRatio {
						randomColor = generateRandomColor()
				}
				
				return randomColor
		}
		
		private func setAdjustedColor(color: rgbColor, difficulty: Difficulty) -> Color {
				let numbers: [Double] = [60, 48, 26, 26, 24, 20, 22, 18, 18, 18, 13, 13]
				var randNum: Double = 0
				
				if difficulty == .survival {
						randNum = numbers.randomElement()!
				}
				
				var increaseValue: Bool = Bool.random()
				
				var adjustedBy: Double {
						switch difficulty {
						case .easy:
								return 60
						case .medium:
								return 48
						case .hard:
								return 26
						case .extreme:
								return 13
						case .survival:
								return randNum
						}
				}
				
				var red = color.red
				var green = color.green
				var blue = color.blue
				
				func adjust() {
						if increaseValue {
								red += adjustedBy
								green += adjustedBy
								blue += adjustedBy
						} else {
								red -= adjustedBy
								green -= adjustedBy
								blue -= adjustedBy
						}
				}
				
				func toLinear(_ value: Double) -> Double {
						return (value <= 0.03928) ? (value / 12.92) : pow((value + 0.055) / 1.055, 2.4)
				}
				
				func relativeLuminance(of color: rgbColor) -> Double {
						let r = toLinear(color.red / 255.0)
						let g = toLinear(color.green / 255.0)
						let b = toLinear(color.blue / 255.0)
						return 0.2126 * r + 0.7152 * g + 0.0722 * b
				}
				
				func checkContrast(reference: rgbColor, color: rgbColor) {
						// If the contrast between the two is too low then adjust the other direction (toggle increase value)
						let luminance1 = relativeLuminance(of: reference)
						let luminance2 = relativeLuminance(of: color)
						var contrast: Double
						var minContrast: Double {
								switch difficulty {
								case .easy:
										return 1.88
								case .medium:
										return 1.47
								case .hard:
										return 1.32
								case .extreme:
										return 1.12
								case .survival:
										return randNum
								}
						}
						
						if luminance1 > luminance2 {
								contrast = (luminance1 + 0.05) / (luminance2 + 0.05)
						} else {
								contrast = (luminance2 + 0.05) / (luminance1 + 0.05)
						}
												
						if contrast < minContrast {
								increaseValue.toggle()
								adjust()
								adjust()
						}
				}
				
				adjust()
				checkContrast(reference: color, color: rgbColor(red: red, green: green, blue: blue))
				
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
