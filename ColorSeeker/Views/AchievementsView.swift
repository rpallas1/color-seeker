//
//  AchievementsView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct AchievementsView: View {
		
		@Environment(\.modelContext) var context
		@Environment(GlobalStates.self) var viewStates
		
		@Query(sort: \AchievementModel.index)
		private var sortedAchievements: [AchievementModel]
		
		@State private var showSettings = false
		@State private var selectedTab = 0
		@State private var screenWidth: CGFloat = 0.0
		@State private var minWidth: CGFloat = 380
		
		@State private var selectedGroup: GroupModel?
		@State private var selectedGoal: Goal?
		
		var body: some View {
				
				@Bindable var viewStates = viewStates

				NavigationStack {
						VStack {
								CustomSegmentedControlView(selectedTab: $selectedTab, segments: sortedAchievements)
								
								TabView(selection: $selectedTab) {
										ForEach(0..<sortedAchievements.count, id: \.self) { index in
												VStack {
														AchievementSheetView(achievementCategory: sortedAchievements[index], selectedGroup: $selectedGroup, selectedGoal: $selectedGoal)
												}
												.tag(index)
										}
								}
								.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
						}
						.navigationBarTitleDisplayMode(.inline)
				}
				.onAppear {
						screenWidth = UIScreen.main.bounds.width
				}
				.sheet(isPresented: $viewStates.showFullDescription) {
						if selectedGroup != nil && selectedGoal != nil {
								FullDescriptionView(group: selectedGroup!, goal: selectedGoal!)
										.presentationDetents([.fraction(screenWidth < minWidth ? 0.35 : 0.3)])
						}
						
				}
		}
}
