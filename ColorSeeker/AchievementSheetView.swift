//
//  AchievementSheetView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 6/3/24.
//

import SwiftUI
import SwiftData
import TipKit

struct AchievementSheetView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var achievementCategory: AchievementModel
		@Binding var selectedGroup: GroupModel?
		@Binding var selectedGoal: Goal?
		var tip = AchievemetTip()
		
		let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				ScrollView {
						VStack(spacing: 28) {
								ForEach(sortedGroups) { group in
										VStack(alignment: .leading, spacing: 20) {
												Text(group.name)
														.font(.title)
														.bold()
												
												if group.index == 0 && achievementCategory.index == 0 {
														TipView(tip, arrowEdge: .bottom)
																.tipViewStyle(AchievementTipViewStyle())
												}
												
												LazyVGrid(columns: columns) {
														ForEach(sortedGoal(for: group)) { goal in
																GoalView(group: group, goal: goal)
																		.padding()
																		.onTapGesture {
																				selectedGroup = group
																				selectedGoal = goal
																				viewStates.showFullDescription = true
																		}
														}
												}
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
												
										}
										.padding(.horizontal, 24)
										.padding(.top)
										.containerRelativeFrame(.horizontal)
								}
						}
						.padding(.bottom, 24)
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
		}
		
		var sortedGroups: [GroupModel] {
				achievementCategory.groups.sorted(by: {$0.index < $1.index})
		}
		
		func sortedGoal(for group: GroupModel) -> [Goal] {
				group.goals.sorted (by: {
						if $0.time != $1.time {
								return $0.time > $1.time
						} else {
								return $0.value < $1.value
						}
				})
		}
}

struct GoalView: View {
		
		var group : GroupModel
		var goal: Goal
		var format = FormatHelper()
		
		var body: some View {
				
				VStack (spacing: 6) {
						Image(systemName: goal.isComplete ? "trophy.fill" : "trophy")
								.foregroundStyle(goal.isComplete ? .accent : .gray)
								.font(Font.system(size: 50))
						Text(format.title(group: group, goal: goal))
								.font(.subheadline)
								.bold()
						if !goal.isComplete {
								Text(format.previewDescription(group: group, goal: goal))
										.font(.caption)
						} else {
								Text("Complete")
										.font(.caption)
						}
				}
				.multilineTextAlignment(.center)
		}
}

struct AchievemetTip: Tip {
		var title: Text {
				Text("Tap for More Details")
		}
		
		var message: Text? {
				Text("Tap on an achievement to see more details")
		}
		
		var image: Image? {
				Image(systemName: "trophy.fill")
		}
}

struct AchievementTipViewStyle: TipViewStyle {
		func makeBody(configuration: TipViewStyle.Configuration) -> some View {
				VStack(alignment: .leading) {
						HStack {
								Spacer()
								Button(action: { configuration.tip.invalidate(reason: .tipClosed)}) {
										Image(systemName: "xmark").scaledToFit()
												.foregroundStyle(.gray)
								}
						}
						
						HStack(alignment: .top, spacing: 20) {
								configuration.image?
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: 48, height: 48)
										.foregroundStyle(.accent)
								
								VStack(alignment: .leading, spacing: 8.0) {
										configuration.title?
												.font(.headline)
										configuration.message?
												.font(.subheadline)
								}
						}
				}
				.padding()
		}
}
