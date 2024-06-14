//
//  HomeView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
		
		@Environment(\.modelContext) var context
		@Environment(GlobalStates.self) var viewStates
								
		@State private var showGameplay = false
		@State private var showSettings = false
		@State private var currentGame = GameplayModel()
		@State private var dimensions: Double = 0.0
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
						ZStack {
								VStack {
										Text("Color Seek")
												.font(.largeTitle)
												.bold()
										
										Spacer()
										
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: dimensions, height: dimensions)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: dimensions, height: dimensions)
																.opacity(0.7)
												}
												
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: dimensions, height: dimensions)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: dimensions, height: dimensions)
												}
										}
										.foregroundStyle(.orange)
										.padding(.bottom, 50)
										
										Spacer()
										
										DifficultyMenuView(currentGame: $currentGame)
								}
						}
						.onAppear {
								dimensions = UIScreen.main.bounds.width * 0.316
						}
				}
		}
}
