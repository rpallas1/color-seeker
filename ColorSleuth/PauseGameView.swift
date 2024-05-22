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
														Text("00:02")
												}
												HStack {
														Text("Score:")
																.bold()
														Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
												}
										}
										.padding(.bottom, 32)
										.font(.title)
								}
								.padding(.trailing, 100)
								
								VStack (spacing: 16) {
										Button(action: {
												viewStates.showGameplay = false
												viewStates.showPause = false
										}, label: {
												Text("Quit")
										})
										
										Button(action: {
												viewStates.showPause = false
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
		}
}
