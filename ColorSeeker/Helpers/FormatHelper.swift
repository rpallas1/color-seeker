//
//  FormatHelper.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/27/24.
//

import Foundation

struct FormatHelper {

		func percent(percent: Double) -> String {
				let roundedPercent = (percent * 10).rounded() / 10
				let tenthsPlace = Int((roundedPercent * 10).truncatingRemainder(dividingBy: 10))
				if tenthsPlace == 0 {
						return String(format: "%.0f%%", percent)
				} else {
						return String(format: "%.1f%%", percent)
				}
		}
		
		func time(elapsedTime: Double) -> String {
				if elapsedTime < 60 {
						let roundedElapsedTime = (elapsedTime * 10).rounded() / 10
						let tenthsPlace = Int((roundedElapsedTime * 10).truncatingRemainder(dividingBy: 10))
						if tenthsPlace == 0 {
								return String(format: "%.0fs", elapsedTime)
						} else {
								return String(format: "%.1fs", elapsedTime)
						}
				} else if elapsedTime < 3600 {
						let minutes = Int(elapsedTime) / 60
						let seconds = Int(elapsedTime) % 60
						return String(format: "%d:%02d", minutes, seconds)
				} else {
						let hours = Int(elapsedTime) / 3600
						let minutes = (Int(elapsedTime) % 3600) / 60
						let seconds = Int(elapsedTime) % 60
						return String(format: "%d:%02d:%02d", hours, minutes, seconds)
				}
		}

		func fullDescripiton(group: GroupModel, goal: Goal) -> String {
				var description = ""
				let time = time(elapsedTime: goal.time)
				
				if goal.isComplete {
						description = group.descriptionString.replacingOccurrences(of: "_", with: String(goal.value))
				} else {
						description = group.descriptionString.replacingOccurrences(of: "_", with: String(goal.value))
				}
				
				if goal.time != 0 {
						description = description.replacingOccurrences(of: "-", with: time.dropLast())
				}
				
				return description
		}
		
		func previewDescription(group: GroupModel, goal: Goal) -> String {
				if goal.isComplete == false {
						if goal.time != 0 {
								return "\(goal.progress) of \(goal.value)"
						}
						return "\(group.progress) of \(goal.value)"
				} else {
						return "\(goal.value) of \(goal.value)"
				}
		}
		
		func title(group: GroupModel, goal: Goal) -> String {
				
				let time = time(elapsedTime: goal.time)
				
				if goal.time != 0 {
						if goal.value == 1 {
								return "Under\n\(time)"
						}
						return "\(goal.value)\nunder \(time)"
				}
				
				return String(goal.value)
		}
}
