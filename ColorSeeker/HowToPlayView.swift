//
//  HowToPlayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct HowToPlayView: View {
		
		@Environment(\.dismiss) private var dismiss
		@State var throughSettings: Bool
		@State private var screenWidth: CGFloat = 0.0
		@State private var largeVSpacing: CGFloat = 0.0
		@State private var smallVSpacing: CGFloat = 0.0
		@State private var hSpacing: CGFloat = 0.0
		@State private var iconSize: CGFloat = 0.0
		@State private var minWidth: CGFloat = 380
		
    var body: some View {
				NavigationStack {
						VStack (spacing: largeVSpacing) {
								if throughSettings {
										Spacer()
								}
								
								VStack (alignment: .leading, spacing: smallVSpacing) {
										HStack (spacing: hSpacing) {
												Image("square.grid.2x2")
														.foregroundStyle(.accent)
														.font(.system(size: iconSize, weight: .semibold))
												Text("Tap the color that's different.")
										}
										
										HStack (spacing: hSpacing) {
												Image(systemName: "checkmark")
														.foregroundStyle(.green)
														.font(.system(size: iconSize, weight: .semibold))
												Text("Get at least 85% correct to complete a game")
										}
										
										HStack (spacing: hSpacing) {
												Image(systemName: "clock")
														.foregroundStyle(.accent)
														.font(.system(size: iconSize, weight: .semibold))
												Text("See how fast you can complete a game.")
										}
										
										HStack (spacing: hSpacing) {
												Image(systemName: "line.diagonal.arrow")
														.foregroundStyle(.orange)
														.font(.system(size: iconSize, weight: .semibold))
												Text("The harder the difficulty, the more similar the colors will be.")
										}
										
										HStack (spacing: hSpacing) {
												Image(systemName: "heart")
														.foregroundStyle(.red)
														.font(.system(size: iconSize, weight: .semibold))
												Text("Try Survival Mode to see how far you can make it without a mistake!")
										}
								}
								.fixedSize(horizontal: false, vertical: true)
								.padding(.horizontal, screenWidth * 0.056)
								
								if throughSettings && screenWidth > minWidth {
										Spacer()
								}
								
								Image("how-to-play")
										.resizable()
										.aspectRatio(contentMode: .fit)
										.frame(width: screenWidth > minWidth ? screenWidth * 0.6 : screenWidth * 0.47)
								
								if throughSettings {
										Spacer()
								}

								if !throughSettings {
										Button(action: {
												dismiss()
										}, label: {
												ZStack {
														RoundedRectangle(cornerRadius: 100)
																.frame(width: 239, height: 50)
																.foregroundStyle(.accent)
														
														Text("Start Playing")
																.foregroundStyle(.white)
																.font(.title2)
																.bold()
												}
										})
								}
						}
						.navigationTitle("How to Play")
						.navigationBarTitleDisplayMode(.inline)
						.onAppear {
								screenWidth = UIScreen.main.bounds.width
								largeVSpacing = UIScreen.main.bounds.width * 0.084
								smallVSpacing = UIScreen.main.bounds.width * 0.046
								hSpacing = UIScreen.main.bounds.width * 0.042
								iconSize = UIScreen.main.bounds.width * 0.06
						}
				}
    }
}
