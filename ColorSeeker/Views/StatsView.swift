//
//  StatsView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		@Query(sort: \StatModel.index)
		private var sortedStats: [StatModel]
		
		@State private var showSettings = false
		
		@State private var selectedTab = 0
		
		var body: some View {
				
				@Bindable var viewStates = viewStates

				NavigationStack {
						VStack {
								CustomSegmentedControlView(selectedTab: $selectedTab, segments: sortedStats)
								
								TabView(selection: $selectedTab) {
										ForEach(0..<sortedStats.count, id: \.self) { index in
												VStack {
														StatSheetView(statCategory: sortedStats[index])
												}
												.tag(index)
										}
								}
								.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
						}
						.navigationBarTitleDisplayMode(.inline)
				}
		}
}
