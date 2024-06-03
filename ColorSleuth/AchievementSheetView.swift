//
//  AchievementSheetView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 6/3/24.
//

import SwiftUI
import SwiftData

struct AchievementSheetView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var achievementCategory: AchievementModel
		@Binding var selectedGroup: GroupModel?
		@Binding var selectedGoal: Goal?
		
		let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

		
    var body: some View {
				
				@Bindable var viewStates = viewStates
				
				ScrollView {
						VStack(spacing: 28) {
								ForEach(achievementCategory.groups.sorted(by: {$0.index < $1.index})) { group in
										VStack(alignment: .leading, spacing: 20) {
												Text(group.name)
														.font(.title)
														.bold()
												LazyVGrid(columns: columns) {
														ForEach(group.goals.sorted(by: {$0.value < $1.value})) { goal in
																GoalView(group: group, goal: goal)
																		.padding(.bottom)
																		.onTapGesture {
																				// TODO: Show sheet with full description
																				selectedGroup = group
																				selectedGoal = goal
																				viewStates.showFullDescription = true
																		}
														}
												}
												
												
										}
										.padding(.horizontal, 24)
										.padding(.top)
										.containerRelativeFrame(.horizontal)
								}
						}
				}
				.padding(.bottom, 24)
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}

struct GoalView: View {
				
		var group : GroupModel
		var goal: Goal
		var format = FormatHelper()
		
		var body: some View {
								
				VStack (spacing: 6) {
						Image(systemName: goal.isComplete ? "trophy.fill" : "trophy")
								.foregroundStyle(goal.isComplete ? .cyan : .gray)
								.font(Font.system(size: 50))
						Text(format.title(group: group, goal: goal))
								.font(.subheadline)
								.bold()
						Text(format.previewDescription(group: group, goal: goal))
								.font(.caption)
				}
				.multilineTextAlignment(.center)
		}
}
