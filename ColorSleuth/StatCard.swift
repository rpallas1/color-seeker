//
//  StatCard.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct StatCard: View {
    var body: some View {
				VStack (spacing: 16) {
						Text("Easy")
								.font(.title)
						
						HStack {
								VStack {
										Text("Best\nTime")
												.bold()
												
										Text("00:23")
												.multilineTextAlignment(.center)
								}
								Spacer()
								VStack {
										Text("Percent\nCorrect")
												.bold()
										Text("100%")
								}
								Spacer()
								VStack {
										Text("Longest\nStreak")
												.bold()
										Text("196")
								}
						}
						
						HStack {
								VStack {
										Text("Average\nTime")
												.bold()
										Text("00:45")
								}
								Spacer()
								VStack {
										Text("Games\nPlayed")
												.bold()
										Text("196")
								}
								Spacer()
								VStack {
										Text("Current\nStreak")
												.bold()
										Text("196")
								}
						}
				}
				.padding()
				.background {
						RoundedRectangle(cornerRadius: 15)
								.foregroundStyle(Color("Primary Gray"))
				}
    }
}

#Preview {
    StatCard()
}
