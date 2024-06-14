//
//  AchievementHelper.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 6/3/24.
//

import Foundation
import SwiftUI

struct AchievementHelper {
		
		func isComplete(group: GroupModel, goal: Goal) -> Bool {
				if goal.time != 0 {
						if goal.progress >= goal.value {
								return true
						}
				}
				
				if group.progress >= goal.value {
						return true
				}
				
				return false
		}
		
		func timeProgress(currentGame: GameplayModel, goal: Goal) -> Bool {
				if currentGame.elapsedTime < goal.time {
						return true
				}
				
				return false
		}
}
