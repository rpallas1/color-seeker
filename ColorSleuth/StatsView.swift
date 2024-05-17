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
		
		var statCategories: [StatCategory]
		@State private var showSettings = false
		
		var body: some View {NavigationStack {
				
				@Bindable var viewStates = viewStates
				
				VStack {
						ScrollView(.horizontal) {
								// List of difficulties
								HStack (spacing: 36) {
										ForEach(statCategories) { category in
												Text(category.difficulty)
														.foregroundStyle(.cyan)
														.bold()
										}
								}
								.padding([.top, .horizontal])
						}
						.scrollIndicators(.hidden)
						
						ScrollView(.horizontal) {
								LazyHStack (spacing: 50) {
										ForEach(statCategories) { category in
												StatCategoryView(statCategory: category)
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
						.presentationDragIndicator(.visible)
		})
				
		}
}
