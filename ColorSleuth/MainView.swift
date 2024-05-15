//
//  ContentView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
				TabView {
						HomeView()
								.tabItem {
										Label("Home", systemImage: "house")
								}
						
						StatsView()
								.tabItem {
										Label("Stats", systemImage: "square.stack.3d.up")
								}
						
						AchievementsView()
								.tabItem {
										Label("Achievements", systemImage: "trophy")
								}
				}
    }
}

#Preview {
    MainView()
}
