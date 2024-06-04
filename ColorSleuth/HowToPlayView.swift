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
		
    var body: some View {
				NavigationStack {
						VStack (spacing: 36) {
								if throughSettings {
										Spacer()
								}
								
								VStack (alignment: .leading, spacing: 20) {
										HStack (spacing: 18) {
												Image("square.grid.2x2")
														.foregroundStyle(.accent)
														.font(.system(size: 26, weight: .semibold))
												Text("Tap the color that's different.")
										}
										
										HStack (spacing: 18) {
												Image(systemName: "checkmark")
														.foregroundStyle(.green)
														.font(.system(size: 26, weight: .semibold))
												Text("Get at least 85% correct to complete a game")
										}
										
										HStack (spacing: 18) {
												Image(systemName: "clock")
														.foregroundStyle(.accent)
														.font(.system(size: 26, weight: .semibold))
												Text("See how fast you can complete a game.")
										}
										
										HStack (spacing: 18) {
												Image(systemName: "line.diagonal.arrow")
														.foregroundStyle(.orange)
														.font(.system(size: 26, weight: .semibold))
												Text("The harder the difficulty, the more similar the colors will be.")
										}
										
										HStack (spacing: 18) {
												Image(systemName: "heart")
														.foregroundStyle(.red)
														.font(.system(size: 26, weight: .semibold))
												Text("Try Survival Mode to see how far you can make it without a mistake!")
										}
								}
								.padding(.horizontal, 24)
								
								if throughSettings {
										Spacer()
								}
								
								Image("how-to-play")
								
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
				}
    }
}
