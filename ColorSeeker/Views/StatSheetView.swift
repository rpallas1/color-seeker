//
//  StatCategory.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct StatSheetView: View {
		
		var statCategory: StatModel
		var format = FormatHelper()

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
										
										if statCategory.difficulty != "Survival" {
												// Game stats for normal difficulties
												HStack {
														Text("Games Won")
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
												
												HStack {
														Text("Perfect Games")
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
														Spacer()
														Text(statCategory.percentCorrect == 0 ? "-" : format.percent(percent: statCategory.percentCorrect))
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
												
												HStack {
														Text("Accuracy")
														Spacer()
														Text(statCategory.accuracy == 0 ? "-" : format.percent(percent: statCategory.accuracy))
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
								
								if statCategory.difficulty != "Survival" {
										// Streaks section, only if not on survival
										VStack (alignment: .leading, spacing: 20) {
												Text("Streaks")
														.font(.title)
														.bold()
												
												HStack {
														Text("Current Win Streak")
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
								} else {
										// Best game for survival instead of streaks
										VStack (alignment: .leading, spacing: 20) {
												Text("Best Game")
														.font(.title)
														.bold()
												
												HStack {
														Text("High Score")
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
												
												HStack {
														Text("Time to Tap")
														Spacer()
														Text(statCategory.bestTimeTapRatioString == "" ? "-" : statCategory.bestTimeTapRatioString)
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
												
												HStack {
														Text("Time")
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
										.padding(.horizontal, 24)
										.padding(.top)
										.containerRelativeFrame(.horizontal)
								}
								
								if statCategory.difficulty != "Survival" {
										// Times section for normal difficulties
										VStack (alignment: .leading, spacing: 20) {
												Text("Times")
														.font(.title)
														.bold()
												
												if statCategory.difficulty != "Overall" {
														HStack {
																Text("Best Time")
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
														Spacer()
														Text(statCategory.averageTimeString == "" ? "-" : statCategory.averageTimeString)
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
										.padding(.bottom, 24)
										.containerRelativeFrame(.horizontal)
								} else {
										// Averge game for survival round
										VStack (alignment: .leading, spacing: 20) {
												Text("Average Game")
														.font(.title)
														.bold()
												
												HStack {
														Text("Average Score")
														Spacer()
														Text(statCategory.averageScore == 0 ? "-" : String(statCategory.averageScore))
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
												
												HStack {
														Text("Average Time to Tap")
														Spacer()
														Text(statCategory.avgTimeTapRatioString == "" ? "-" : statCategory.avgTimeTapRatioString)
																.bold()
												}
												.padding()
												.font(.title3)
												.background {
														RoundedRectangle(cornerRadius: 15)
																.foregroundStyle(Color("Primary Gray"))
												}
												
												HStack {
														Text("Average Time")
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
										.padding(.bottom, 24)
										.containerRelativeFrame(.horizontal)
								}
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
		}		
}
