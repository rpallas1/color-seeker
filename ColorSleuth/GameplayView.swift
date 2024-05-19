//
//  GameplayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var selectedDifficulty: String

		@State private var showSettings: Bool = false
		@State private var showEndRound = false
		var updateStats: StatHelper = StatHelper()
		var gameplay: GameplayModel = GameplayModel()
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						ZStack {
								VStack {
										HStack {
												Spacer()
												VStack {
														Text("Score")
																.bold()
														Text("0/2")
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												
												Spacer()
												Spacer()
												
												VStack {
														Text("Time")
																.bold()
														Text("00:41")
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												Spacer()
										}
										.padding(.horizontal, 30)
										
										Spacer()
										
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.opacity(0.7)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		gameplay.difficulty = selectedDifficulty
																		gameplay.score += 1
																		
																		viewStates.showEndRound = true
																}
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
								}
								.toolbar {
										ToolbarItem {
												Button(action: {
														showSettings = true
												}, label: {
														Image(systemName: "gear")
																.foregroundStyle(Color("Primary Black"))
												})
										}
										
										ToolbarItem(placement: .topBarLeading) {
												Button(action: {
														viewStates.showPause.toggle()
												}, label: {
														Image(systemName: viewStates.showPause ? "play.fill" : "pause.fill")
																.foregroundStyle(Color("Primary Black"))
												})
										}
								}
								
								if viewStates.showPause {
										PauseGameView()
								}
								
								if viewStates.showEndRound {
										RoundFinishedView(selectedDifficulty: selectedDifficulty, currentGame: gameplay)
								}
						}
				}
				.sheet(isPresented: $showSettings, content: {
						SettingsView()
								.presentationDragIndicator(.visible)
				})
		}
}

