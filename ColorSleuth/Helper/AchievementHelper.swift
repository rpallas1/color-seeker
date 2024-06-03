//
//  AchievementHelper.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 6/3/24.
//

import Foundation
import SwiftUI

struct AchievementHelper {
		
		func isComplete(group: [GroupModel], goal: [Goal]) -> Bool {
				
				return false
		}
		
		func timeProgress(currentGame: GameplayModel, goal: Goal) -> Bool {
				if Int(currentGame.elapsedTime) < goal.time {
						return true
				}
				
				return false
		}
}
