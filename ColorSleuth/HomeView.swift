//
//  HomeView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct HomeView: View {
		
		@Environment(GlobalStates.self) var viewStates
						
		@State private var showGameplay = false
		@State private var showSettings = false
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				NavigationStack {
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

								Button(action: {
										// TODO: Bring up difficulty options
										viewStates.showGameplay = true
								}, label: {
										ZStack {
												RoundedRectangle(cornerRadius: 100)
														.frame(width: 239, height: 50)
														.foregroundStyle(.cyan)
												
												Text("New Game")
														.foregroundStyle(.white)
														.font(.title2)
														.bold()
										}
								})
								.padding(.bottom, 20)
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
								.presentationDragIndicator(.visible)
				})
				.fullScreenCover(isPresented: $viewStates.showGameplay, content: {
						GameplayView()
				})
		}
}

#Preview {
		HomeView()
}
