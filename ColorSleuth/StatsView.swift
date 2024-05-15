//
//  StatsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct StatsView: View {
		
		@State private var showSettings = false
		
		var body: some View {
				NavigationStack {
						ScrollView {
								VStack (spacing: 20) {
										// List of Stat Cards
										StatCard()
										StatCard()
										StatCard()
										StatCard()
										StatCard()
										StatCard()
								}
								.padding(.top, 30)
						}
						.padding(.horizontal)
						.scrollIndicators(.hidden)
						.navigationTitle("Stats")
						.navigationBarTitleDisplayMode(.inline)
						.toolbar {
								ToolbarItem {
										Button(action: {
												showSettings = true
										}, label: {
												Image(systemName: "gear")
														.foregroundStyle(.black)
										})
								}
						}
						.sheet(isPresented: $showSettings, content: {
								SettingsView()
						})

				}

		}
}

#Preview {
		StatsView()
}
