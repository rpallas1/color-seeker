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
				
				for i in 0..<gridSize {
						gridLayout.append(assignSquareValues(gridSize: gridSize, index: i))
				}
				
				return gridLayout
		}
		
		func assignSquareValues(gridSize: Int, index: Int) -> SquareObject {
						
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
				
				if index == 0 {
						return SquareObject(color: .blue, isAnswer: true, size: size, cornerRadius: radius)
				} else {
						return SquareObject(color: .orange, isAnswer: false, size: size, cornerRadius: radius)
				}
		}
}
