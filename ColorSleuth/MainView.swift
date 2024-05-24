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
		@State var selection = Tabs.home
		@State private var showSettings = false

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
												Label("Stats", systemImage: "square.stack.3d.up")
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
								if allStats.count == 0 {
										initStats()
										print(context.sqliteCommand)
								} else {
										print(context.sqliteCommand)
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
		
		func initStats() {
				context.insert(StatModel(difficuly: "Overall", position: 0))
				context.insert(StatModel(difficuly: "Easy", position: 1))
				context.insert(StatModel(difficuly: "Medium", position: 2))
				context.insert(StatModel(difficuly: "Hard", position: 3))
				context.insert(StatModel(difficuly: "Extreme", position: 4))
				context.insert(StatModel(difficuly: "Survival", position: 5))
		}
}

enum Tabs: String {
		case home
		case stats
		case achievements
}
