//
//  NewBestView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 6/10/24.
//

import SwiftUI

struct NewBestView: View {
		
		var currentGame: GameplayModel
		var newHighScore: Bool?
		var newBestTime: Bool?
		var width: CGFloat
		private var format = FormatHelper()
		private var trailingPadding: CGFloat = 0.75
		
		var body: some View {
				if newHighScore ==  true {
						VStack(alignment: .leading) {
								HStack (spacing: 8) {
										Image(systemName: "chart.bar.xaxis")
												.foregroundStyle(.accent)
										
										Text("New High Score:")
												.bold()
										
										Text(String(currentGame.score))
										
										Spacer()
								}
								.font(.title2)
						}
						.frame(width: width * trailingPadding)
						.padding([.vertical, .leading])
						.background {
								RoundedRectangle(cornerRadius: 12)
										.foregroundStyle(Color("Primary Gray"))
										.shadow(radius: 6)
						}
				}
				
				if newBestTime == true {
						VStack(alignment: .leading) {
								HStack (spacing: 8) {
										Image(systemName: "chart.bar.xaxis")
												.foregroundStyle(.accent)
										
										Text("New Best Time:")
												.bold()
										
										Text(format.time(elapsedTime: Double(currentGame.elapsedTime)))
										
										Spacer()
								}
								.font(.title2)
						}
						.frame(width: width * trailingPadding)
						.padding([.vertical, .leading])
						.background {
								RoundedRectangle(cornerRadius: 12)
										.foregroundStyle(Color("Primary Gray"))
										.shadow(radius: 6)
						}
				}
		}
		
		init(currentGame: GameplayModel, newHighScore: Bool? = nil, newBestTime: Bool? = nil, width: CGFloat) {
				self.currentGame = currentGame
				self.newHighScore = newHighScore
				self.newBestTime = newBestTime
				self.width = width
		}
}
