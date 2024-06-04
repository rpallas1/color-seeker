//
//  DifficultyMenuView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/20/24.
//

import SwiftUI
import SwiftData

struct DifficultyMenuView: View {
		
		@Environment(GlobalStates.self) var viewStates
		@Environment(Settings.self) var settings
		
		@Binding var currentGame: GameplayModel
		@State private var game = GameHelper()
		
    var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						Menu {
								Button(action: {
										viewStates.showGameplay = true
										currentGame.difficulty = .easy
										currentGame.gridSize = .small
								}, label: {
										Text("Easy")
								})
								
								Button(action: {
										viewStates.showGameplay = true
										currentGame.difficulty = .medium
										currentGame.gridSize = .medium
								}, label: {
										Text("Medium")
								})
								
								Button(action: {
										viewStates.showGameplay = true
										currentGame.difficulty = .hard
										currentGame.gridSize = .medium
								}, label: {
										Text("Hard")
								})
								
								Button(action: {
										viewStates.showGameplay = true
										currentGame.difficulty = .extreme
										currentGame.gridSize = .large
								}, label: {
										Text("Extreme")
								})
								
								Button(action: {
										viewStates.showGameplay = true
										currentGame.difficulty = .survival								
										currentGame.gridSize = .large
										
										// Will go on until a mistake is made
										currentGame.totalRounds = -1
								}, label: {
										Text("Survival")
								})
						} label: {
								ZStack {
										RoundedRectangle(cornerRadius: 100)
												.frame(width: 239, height: 50)
												.foregroundStyle(.accent)
										
										Text("New Game")
												.foregroundStyle(.white)
												.font(.title2)
												.bold()
								}
						}
						.padding(.bottom, 45)
						.menuOrder(.fixed)
						.navigationDestination(isPresented: $viewStates.showGameplay) {
								GameplayView(currentGame: currentGame, gridArray: game.buildGrid(currentGame: currentGame, colorScheme: settings.referenceColor(for: settings.colorScheme)))
										.navigationBarBackButtonHidden()
										.toolbar(.hidden, for: .tabBar)
						}
				}
    }
}
