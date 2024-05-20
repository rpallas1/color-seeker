//
//  HomeView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
		
		@Environment(\.modelContext) var context
		@Environment(GlobalStates.self) var viewStates
		
//		@Query var currentGames: [GameplayModel]
		var currentGame = GameplayModel(difficulty: .easy)
						
		@State private var showGameplay = false
		@State private var showSettings = false
//		@State private var selectedDiff: Difficulty = .easy
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						ZStack {
								VStack {
										Text("Color Sleuth")
												.font(.largeTitle)
												.bold()
										
										Spacer()
										
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.opacity(0.7)
												}
												
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
												}
										}
										.foregroundStyle(.orange)
										.padding(.bottom, 50)
										
										Spacer()
										
//										DifficultyMenuView(selectedDiff: $selectedDiff)
										DifficultyMenuView(currentGame: currentGame)
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
				.fullScreenCover(isPresented: $viewStates.showGameplay, content: {
						GameplayView(currentGame: currentGame)
//						if currentGames.count == 1 {
//								ForEach(currentGames) { game in
//										GameplayView(currentGame: game)
//								}
//						} else {
//								Text("Error: Returned more than one current game")
//						}
				})
		}
}
