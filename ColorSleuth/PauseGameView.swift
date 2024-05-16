//
//  PauseGameView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI

struct PauseGameView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				GroupBox {
						VStack {
								HStack {
										VStack (alignment: .leading, spacing: 24) {
												HStack {
														Text("Difficulty:")
																.bold()
														Text("Easy")
												}
												HStack {
														Text("Time:")
																.bold()
														Text("00:41")
												}
												HStack {
														Text("Score:")
																.bold()
														Text("5/20")
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

#Preview {
		PauseGameView()
}
