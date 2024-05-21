//
//  StatCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct StatSheetView: View {
		
		var statCategory: StatModel
		
		var body: some View {
				ScrollView {
						// List of all stats belonging to a single difficulty
						VStack (spacing: 28) {
								
								// Games sections
								VStack (alignment: .leading, spacing: 20) {
										Text("Games")
												.font(.title)
												.bold()
										
										HStack {
												Text("Games Played")
														.padding(.leading)
												Spacer()
												Text(statCategory.gamesPlayed == 0 ? "-" : String(statCategory.gamesPlayed))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										HStack {
												Text("Games Won")
														.padding(.leading)
												Spacer()
												Text(statCategory.gamesWon == 0 ? "-" : String(statCategory.gamesWon))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										HStack {
												Text("Win Rate")
														.padding(.leading)
												Spacer()
												Text(statCategory.percentCorrect == 0 ? "-" : String(statCategory.percentCorrect))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
								}
								.padding(.horizontal, 24)
								.padding(.top)
								.containerRelativeFrame(.horizontal)
								
								// Streaks section
								VStack (alignment: .leading, spacing: 20) {
										Text("Streaks")
												.font(.title)
												.bold()
										
										HStack {
												Text("Current Streak")
														.padding(.leading)
												Spacer()
												Text(statCategory.currentStreak == 0 ? "-" : String(statCategory.currentStreak))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										HStack {
												Text("Longest Streak")
														.padding(.leading)
												Spacer()
												Text(statCategory.bestStreak == 0 ? "-" : String(statCategory.bestStreak))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
								}
								.padding(.horizontal, 24)
								.padding(.top)
								.containerRelativeFrame(.horizontal)
								
								// Times section
								VStack (alignment: .leading, spacing: 20) {
										Text("Time")
												.font(.title)
												.bold()
										
										HStack {
												Text("Best Time")
														.padding(.leading)
												Spacer()
												Text(statCategory.bestTime == 0 ? "-" : String(statCategory.bestTime))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										HStack {
												Text("Average Time")
														.padding(.leading)
												Spacer()
												Text(statCategory.averageTime == 0 ? "-" : String(statCategory.averageTime))
												
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
								}
								.padding(.horizontal, 24)
								.padding(.top)
								.containerRelativeFrame(.horizontal)
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
		}
}
