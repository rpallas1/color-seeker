//
//  PauseGameView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI

struct PauseGameView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var currentGame: GameplayModel
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
//				ZStack {
//						Color.black.opacity(0.4)
//								.ignoresSafeArea()
						
						GroupBox {
								VStack {
										HStack {
												VStack (alignment: .leading, spacing: 24) {
														HStack {
																Text("Difficulty:")
																		.bold()
																Text(currentGame.difficulty.rawValue)
														}
														HStack {
																Text("Time:")
																		.bold()
																Text(currentGame.elapsedTimeString)
														}
														HStack {
																Text("Score:")
																		.bold()
																
																if currentGame.difficulty == .survival {
																		Text("\(String(currentGame.score))")
																} else {
																		Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
																}
														}
												}
												.padding(.bottom, 32)
												.font(.title)
										}
										.padding(.trailing, 100)
										
										VStack (spacing: 16) {
												Button(action: {
														viewStates.showGameplay = false
														
														// Reset current game values when game quit
														currentGame.score = 0
														currentGame.totalTaps = 0
														currentGame.totalRounds = 20
												}, label: {
														Text("Quit")
												})
												
												Button(action: {
														withAnimation {
																viewStates.showPause = false
														}
														
												}, label: {
														Text("Resume")
																.padding(.horizontal, 48)
																.bold()
												})
												.buttonStyle(.bordered)
										}
										.font(.largeTitle)
								}
						}
//						.zIndex(2)
//				}
				
		}
}
