//
//  StatsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct StatsView: View {
		
		@Environment(\.modelContext) var context
		@Environment(GlobalStates.self) var viewStates
		
		@Query(sort: \StatModel.position)
		private var sortedStats: [StatModel]
		
		@State private var showSettings = false
		
		var body: some View {NavigationStack {
				
				@Bindable var viewStates = viewStates
				
				VStack {
						ScrollView(.horizontal) {
								// List of difficulties at the top
								HStack (spacing: 36) {
										ForEach(sortedStats) { stat in
												Text(stat.difficulty)
														.foregroundStyle(.cyan)
														.bold()
										}
								}
								.padding([.top, .horizontal])
						}
						.scrollIndicators(.hidden)
						
						// List of all the stat sheets by difficulty
						ScrollView(.horizontal) {
								LazyHStack (spacing: 50) {
										ForEach(sortedStats) { stat in
												StatSheetView(statCategory: stat)
										}
								}
								.scrollTargetLayout()
						}
						.scrollIndicators(.hidden)
						.contentMargins(.horizontal, 16)
						.scrollTargetBehavior(.viewAligned)
						
				}
				.navigationTitle("Stats")
				.navigationBarTitleDisplayMode(.inline)
				.toolbar {
						ToolbarItem {
								Button(action: {
										showSettings.toggle()
								}, label: {
										Image(systemName: "gear")
												.foregroundStyle(Color("Primary Black"))
								})
						}
				}
		}
		.sheet(isPresented: $showSettings, content: {
				SettingsView()
		})
				
		}
}
