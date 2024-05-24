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
														.bold()
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										if statCategory.difficulty == "Survival" {
												HStack {
														Text("Highest Score")
																.padding(.leading)
														Spacer()
														Text(statCategory.highScore == 0 ? "-" : String(statCategory.highScore))
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
										} else {
												HStack {
														Text("Games Won")
																.padding(.leading)
														Spacer()
														Text(statCategory.gamesWon == 0 ? "-" : String(statCategory.gamesWon))
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
										}
										
										HStack {
												Text("Perfect Games")
														.padding(.leading)
												Spacer()
												Text(statCategory.perfectGames == 0 ? "-" : String(statCategory.perfectGames))
														.bold()
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
												Text(statCategory.percentCorrect == 0 ? "-" : "\(String(statCategory.percentCorrect))%")
														.bold()
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										if statCategory.difficulty != "Survival" {
												HStack {
														Text("Accuracy")
																.padding(.leading)
														Spacer()
														Text(statCategory.accuracy == 0 ? "-" : "\(String(statCategory.accuracy))%")
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
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
												Text("Current Win Streak")
														.padding(.leading)
												Spacer()
												Text(statCategory.currentStreak == 0 ? "-" : String(statCategory.currentStreak))
														.bold()
										}
										.padding()
										.font(.title3)
										.background {
												RoundedRectangle(cornerRadius: 15)
														.foregroundStyle(Color("Primary Gray"))
										}
										
										HStack {
												Text("Longest Win Streak")
														.padding(.leading)
												Spacer()
												Text(statCategory.bestStreak == 0 ? "-" : String(statCategory.bestStreak))
														.bold()
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
										
										if statCategory.difficulty != "Overall" {
												HStack {
														Text("Best Time")
																.padding(.leading)
														Spacer()
														Text(statCategory.bestTimeString == "" ? "-" : String(statCategory.bestTimeString))
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
										}
										
										HStack {
												Text("Average Time")
														.padding(.leading)
												Spacer()
												Text(statCategory.averageTimeString == "" ? "-" : String(statCategory.averageTimeString))
														.bold()
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
				.padding(.bottom, 24)
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
		}
		
		// TODO: init
}
