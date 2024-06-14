//
//  AchievementModel.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 6/3/24.
//

import Foundation
import SwiftData

@Model
class AchievementModel: Identifiable, ModelProtocal {
		
		var difficulty: String
		var index: Int
		@Relationship(deleteRule: .cascade) var groups: [GroupModel]
		
		init(difficulty: String, index: Int, groups: [GroupModel]) {
				self.difficulty = difficulty
				self.index = index
				self.groups = groups
		}
}

@Model
class GroupModel: Identifiable {
		
		var name: String
		var index: Int
		var descriptionString: String
		var progress: Int
		@Relationship(deleteRule: .cascade) var goals: [Goal]
		
		init(name: String, index: Int, descriptionString: String, progress: Int, goals: [Goal]) {
				self.name = name
				self.index = index
				self.descriptionString = descriptionString
				self.progress = progress
				self.goals = goals
		}
}

@Model
class Goal: Identifiable {
		
		var value: Int
		var time: Double
		var isComplete: Bool
		var progress: Int
		
		init(value: Int, time: Double = 0, isComplete: Bool, progress: Int = 0) {
				self.value = value
				self.time = time
				self.isComplete = isComplete
				self.progress = progress
		}
}
