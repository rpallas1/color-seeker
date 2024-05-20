//
//  DifficultyMenuView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/20/24.
//

import SwiftUI

struct DifficultyMenuView: View {
		
		@Environment(GlobalStates.self) var viewStates
		
		@Binding var selectedDiff: Difficulty
		
    var body: some View {
				
				@Bindable var viewStates = viewStates
				
				Menu {
						Button(action: {
								viewStates.showGameplay = true
								selectedDiff = .easy
						}, label: {
								Text("Easy")
						})
						
						Button(action: {
								viewStates.showGameplay = true
								selectedDiff = .medium
						}, label: {
								Text("Medium")
						})
						
						Button(action: {
								viewStates.showGameplay = true
								selectedDiff = .hard
						}, label: {
								Text("Hard")
						})
						
						Button(action: {
								viewStates.showGameplay = true
								selectedDiff = .medium
						}, label: {
								Text("Extreme")
						})
						
						Button(action: {
								viewStates.showGameplay = true
								selectedDiff = .survival
						}, label: {
								Text("Survival")
						})
				} label: {
						ZStack {
								RoundedRectangle(cornerRadius: 100)
										.frame(width: 239, height: 50)
										.foregroundStyle(.cyan)
								
								Text("New Game")
										.foregroundStyle(.white)
										.font(.title2)
										.bold()
						}
				}
				.padding(.bottom, 20)
				.menuOrder(.fixed)
    }
}
