//
//  ContentView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
		
		@Environment(\.modelContext) var context
		@Environment(Settings.self) var settings
		
		@Query private var allStats: [StatModel]
		@Query private var allAchievements: [AchievementModel]
		@State var selection = Tabs.home
		@State private var showSettings = false
		
		// Define state property for the context to be passed outside of a view
		@State private var defaultData: DefaultDataHelper?

    var body: some View {
				NavigationStack {
						TabView(selection: $selection) {
								HomeView()
										.tabItem {
												Label("Home", systemImage: "house")
										}
										.tag(Tabs.home)
								
								StatsView()
										.tabItem {
												Label("Stats", systemImage: "chart.bar.xaxis")
										}
										.tag(Tabs.stats)
								
								AchievementsView()
										.tabItem {
												Label("Achievements", systemImage: "trophy")
										}
										.tag(Tabs.achievements)
						}
						.navigationTitle(selection.rawValue == "home" ? "" : selection.rawValue.capitalized)
						.navigationBarTitleDisplayMode(.inline)
						.navigationBarBackButtonHidden()
						.onAppear {
								defaultData = DefaultDataHelper(context: context)
								
								if allStats.count == 0 && allAchievements.count == 0 {
										defaultData!.initStats()
										defaultData!.initAchievemnets()
//										print(context.sqliteCommand)
								} else {
										// TODO: Delete and re-init achievements for on-device
//										print(context.sqliteCommand)
								}
						}
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

enum Tabs: String {
		case home
		case stats
		case achievements
}
