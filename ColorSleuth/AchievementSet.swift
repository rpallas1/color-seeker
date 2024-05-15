//
//  AchievementSet.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementSet: View {
    var body: some View {
				VStack (alignment: .leading, spacing: 20) {
						Text("Games Played")
								.font(.title2)
								.bold()
						HStack {
								VStack (spacing: 8) {
										Image(systemName: "trophy.fill")
												.foregroundStyle(.cyan)
												.font(Font.system(size: 50))
										Text("Play 25\nGames")
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy.fill")
												.foregroundStyle(.cyan)
												.font(Font.system(size: 50))
										Text("Play 100\nGames")
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text("Play 250\nGames")
								}
						}
						.padding(.horizontal, 24)
						
						HStack {
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text("Play 500\nGames")
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text("Play 1000\nGames")
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text("Play 5000\nGames")
								}
						}
						.padding(.horizontal, 24)
				}
				.padding(.top, 30)
    }
}

#Preview {
    AchievementSet()
}
