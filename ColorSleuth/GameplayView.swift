//
//  GameplayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct GameplayView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var currentGame: GameplayModel

		@State private var showSettings: Bool = false
		@State private var showEndRound = false
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						ZStack {
								VStack {
										HStack {
												Spacer()
												
												VStack (alignment: .leading) {
														Text("Difficulty:")
																.bold()
														Text(currentGame.difficulty.rawValue)
												}
												
												Spacer()
												
												VStack {
														Text("Score")
																.bold()
														Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												
												Spacer()
												
												VStack {
														Text("Time")
																.bold()
														Text("00:02")
																.foregroundStyle(.white)
																.padding(.horizontal)
																.background {
																		RoundedRectangle(cornerRadius: 8)
																				.foregroundStyle(.cyan)
																}
												}
												Spacer()
										}
										
										Spacer()
										
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.opacity(0.7)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		currentGame.score += 1
																		
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
												}
												
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.onTapGesture {
																		// TODO: Create StatModel instance or add to if already exists for difficulty
																		withAnimation {
																				viewStates.showEndRound = true
																		}
																}
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
										PauseGameView(currentGame: currentGame)
								}
								
								if viewStates.showEndRound {
										RoundFinishedView(currentGame: currentGame)
												.transition(.push(from: .bottom))
								}
						}
				}
				.sheet(isPresented: $showSettings, content: {
						SettingsView()
				})
		}
}
