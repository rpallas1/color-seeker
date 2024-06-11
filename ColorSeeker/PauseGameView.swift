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
		var format = FormatHelper()
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
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
																Text(format.time(elapsedTime: Double(currentGame.elapsedTime)))
														}
														if currentGame.difficulty != .survival {
																HStack {
																		Text("Round:")
																				.bold()
																		Text("\(currentGame.totalTaps)/\(currentGame.totalRounds)")
																}
														}
														HStack {
																Text("Score:")
																		.bold()
																Text("\(currentGame.score)")
														}
												}
												.padding(.bottom, 32)
												.font(.title)
										}
										.padding(.trailing, 100)
										
										VStack (spacing: 20) {
												Button(action: {
														viewStates.showGameplay = false
														
														// Reset current game values when game quit
														currentGame.resetProperties()
												}, label: {
														Text("Quit")
																.padding(.horizontal, 48)
																.foregroundStyle(.red)
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
												.tint(.accent)
										}
										.font(.largeTitle)
								}
						}
		}
}
