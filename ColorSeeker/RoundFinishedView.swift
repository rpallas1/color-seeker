//
//  RoundFinishedView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData
//import TelemetryDeck

struct RoundFinishedView: View {
		
		@Environment(GlobalStates.self) var viewStates
		@Environment(\.dismiss) var dismiss
		
		@Query(filter: #Predicate<StatModel> { stat in
				stat.difficulty == "Medium"
		})
		private var difficultyStat: [StatModel]
		
		@Query(filter: #Predicate<StatModel> { stat in
				stat.difficulty == "Overall"
		})
		private var overallStat: [StatModel]
		
		@Query(filter: #Predicate<AchievementModel> { achievement in
				achievement.difficulty == "Medium"
		})
		private var difficultyAchievement: [AchievementModel]
		
		@Query(filter: #Predicate<AchievementModel> { achievement in
				achievement.difficulty == "Overall"
		})
		private var overallAchievement: [AchievementModel]
		
		@State var currentGame: GameplayModel
		private var calc = CalcStats()
		private var format = FormatHelper()
		private var check = AchievementHelper()
		@State private var newHighScore = false
		@State private var newBestTime = false
		@State private var didPassRound = false
		@State private var newAchievements = [NewAchievement]()
		@State private var screenWidth: CGFloat = 0.0
		private var trailingPadding: CGFloat = 0.75
		
		var body: some View {
				
				@Bindable var viewStates = viewStates
				
				VStack(spacing: 20) {
						Spacer()
						
						if currentGame.difficulty != .survival {
								VStack (spacing: 8) {
										if didPassRound {
												Text("Round Complete!")
														.font(.largeTitle)
														.bold()
										} else {
												Text("Round Failed")
														.font(.largeTitle)
														.bold()
										}
										
										Text("\(format.percent(percent: calc.percentCorrect(currentGame: currentGame)))")
												.font(.largeTitle)
								}
						}
						
						VStack (alignment: .leading, spacing: 16) {
								HStack (spacing: 8) {
										Text("Difficulty:")
												.bold()
										Text(currentGame.difficulty.rawValue)
										Spacer()
								}
								.font(.title2)
								
								HStack (spacing: 8) {
										Text("Time:")
												.bold()
										Text(format.time(elapsedTime: Double(currentGame.elapsedTime)))
										Spacer()
								}
								.font(.title2)
								
								HStack (spacing: 8) {
										Text("Score:")
												.bold()
										
										if currentGame.difficulty == .survival {
												Text(String(currentGame.score))
										} else {
												Text("\(String(currentGame.score))/\(currentGame.totalRounds)")
										}
										Spacer()
								}
								.font(.title2)
						}
						.frame(width: screenWidth * trailingPadding)
						.padding([.vertical, .leading])
						.background {
								RoundedRectangle(cornerRadius: 12)
										.foregroundStyle(Color("Primary Gray"))
										.shadow(radius: 6)
						}
						
						if newHighScore {
								NewBestView(currentGame: currentGame, newHighScore: newHighScore, width: screenWidth)
						}
						
						if newBestTime && didPassRound {
								NewBestView(currentGame: currentGame, newBestTime: newBestTime, width: screenWidth)
						}
						
						if newAchievements.count > 0 {
								
								VStack {
										Text("Achievements Earned")
												.foregroundStyle(.gray)
												.fontWeight(.medium)
												.frame(maxWidth: (screenWidth * trailingPadding) + 16, alignment: .leading)
										
										ScrollView(.horizontal) {
												HStack(spacing: 16) {
														ForEach(newAchievements) { achievement in
																NewAchievementsView(achievement: achievement, width: screenWidth, count: newAchievements.count)
																		.containerRelativeFrame(.horizontal, count: 1, spacing: 16)
														}
												}
												.scrollTargetLayout()
										}
										.scrollIndicators(.hidden)
										.contentMargins(.horizontal, screenWidth * 0.13, for: .scrollContent)
										.scrollTargetBehavior(.viewAligned)
								}
								.padding(.top, 16)
						}
						
						Spacer()
						
						Button(action: {
								viewStates.showGameplay = false
						}, label: {
								ZStack {
										RoundedRectangle(cornerRadius: 100)
												.frame(width: 239, height: 50)
												.foregroundStyle(.accent)
										
										Text("Play Again")
												.foregroundStyle(.white)
												.font(.title2)
												.bold()
								}
						})
						.padding(.bottom, 65)
				}
				.onAppear {
						//Update all stats
						updateStats()
						screenWidth = UIScreen.main.bounds.width
				}
				.onDisappear {
						// Reset current game values
						currentGame.resetProperties()
				}
		}
		
		
		init(currentGame: GameplayModel) {
				// Query only for the difficulty that was played in the current game
				if currentGame.difficulty == Difficulty.easy {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Easy"
						})
						
						_difficultyAchievement = Query(filter: #Predicate<AchievementModel> { achievement in
								achievement.difficulty == "Easy"
						})
				}
				else if currentGame.difficulty == Difficulty.medium {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Medium"
						})
						
						_difficultyAchievement = Query(filter: #Predicate<AchievementModel> { achievement in
								achievement.difficulty == "Medium"
						})
				}
				else if currentGame.difficulty == Difficulty.hard {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Hard"
						})
						
						_difficultyAchievement = Query(filter: #Predicate<AchievementModel> { achievement in
								achievement.difficulty == "Hard"
						})
				}
				else if currentGame.difficulty == Difficulty.extreme {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Extreme"
						})
						
						_difficultyAchievement = Query(filter: #Predicate<AchievementModel> { achievement in
								achievement.difficulty == "Extreme"
						})
				}
				else if currentGame.difficulty == Difficulty.survival {
						_difficultyStat = Query(filter: #Predicate<StatModel> { stat in
								stat.difficulty == "Survival"
						})
						
						_difficultyAchievement = Query(filter: #Predicate<AchievementModel> { achievement in
								achievement.difficulty == "Survival"
						})
				}
				
				self.currentGame = currentGame
		}
		
		private func updateStats() {
				if difficultyStat.count == 1 && overallStat.count == 1 {
						let stat = difficultyStat[0]
						let overallStat = overallStat[0]
						let achievement = difficultyAchievement[0]
						let sortedGroups = achievement.groups.sorted(by: {$0.index < $1.index})
						let overallAchievement = overallAchievement[0]
						let sortedOverallGroups = overallAchievement.groups.sorted(by: {$0.index < $1.index})
						var sortedTimeGoals: [Goal] {
								if currentGame.difficulty != .survival {
										return sortedGroups[3].goals.sorted(by: {
												if $0.time != $1.time {
														return $0.time > $1.time
												} else {
														return $0.value < $1.value
												}
										})
								} else {
										return [Goal]()
								}
						}
						var sortedBestTimeGoals: [Goal] {
								if currentGame.difficulty != .survival {
										return sortedGroups[4].goals.sorted(by: {
												if $0.time != $1.time {
														return $0.time > $1.time
												} else {
														return $0.value < $1.value
												}
										})
								} else {
										return [Goal]()
								}
						}
						
						didPassRound = calc.didPassRound(currentGame: currentGame)
						
						// ROOT STATS
						if !(currentGame.score == 0 && currentGame.difficulty == .survival) {
								stat.gamesPlayed += 1
								stat.totalTime += currentGame.elapsedTime
								sortedOverallGroups[0].progress += 1
						}
						
						stat.totalTaps += currentGame.totalTaps
						stat.correctTaps += currentGame.score
						
						sortedGroups[0].progress = stat.gamesPlayed
						
						if currentGame.difficulty == .survival {
								newHighScore = currentGame.score > stat.highScore
								
								if currentGame.score > stat.highScore {
										stat.highScore = calc.highScore(currentScore: currentGame.score, highScore: stat.highScore)
										stat.bestTimeTapRatio = calc.currentTimeTapRatio(currentGame: currentGame)
										stat.bestTimeTapRatioString = format.time(elapsedTime: stat.bestTimeTapRatio)
										stat.bestTime = currentGame.elapsedTime
										stat.bestTimeString = format.time(elapsedTime: stat.bestTime)
								}
								
								if currentGame.score != 0 {
										stat.averageScore = calc.averageScore(correctTaps: stat.correctTaps, gamesPlayed: stat.gamesPlayed)
										stat.avgTimeTapRatio = calc.avgTimeTapRatio(stats: stat)
										stat.avgTimeTapRatioString = format.time(elapsedTime: stat.avgTimeTapRatio)
										stat.averageTime = calc.averageTime(gamesPlayed: stat.gamesPlayed, totalTime: stat.totalTime)
										stat.averageTimeString = format.time(elapsedTime: stat.averageTime)
								}
								
								sortedGroups[1].progress = stat.highScore
						}
						
						if currentGame.difficulty != .survival {
								// ROOT STATS
								overallStat.gamesPlayed += 1
								overallStat.totalTime += currentGame.elapsedTime
								overallStat.totalTaps += currentGame.totalTaps
								overallStat.correctTaps += currentGame.score
								
								if didPassRound {
										stat.gamesWon += 1
										overallStat.gamesWon += 1
										
										stat.currentStreak += 1
										overallStat.currentStreak += 1
										
										for goal in sortedTimeGoals {
												if check.timeProgress(currentGame: currentGame, goal: goal) {
														goal.progress += 1
												}
										}
										
										for goal in sortedBestTimeGoals {
												if check.timeProgress(currentGame: currentGame, goal: goal) {
														goal.progress += 1
												}
										}
								} else {
										stat.currentStreak = 0
										overallStat.currentStreak = 0
								}
								
								sortedGroups[2].progress = stat.currentStreak
								sortedOverallGroups[2].progress = overallStat.currentStreak
								
								if calc.isPerfectRound(currentGame: currentGame) {
										stat.perfectGames += 1
										overallStat.perfectGames += 1
										
										sortedGroups[1].progress = stat.perfectGames
										sortedOverallGroups[1].progress = overallStat.perfectGames
								}
								
								stat.percentCorrect = calc.winRate(stat: stat)
								overallStat.percentCorrect = calc.winRate(stat: overallStat)
								
								stat.accuracy = calc.accuracy(stat: stat)
								overallStat.accuracy = calc.accuracy(stat: overallStat)
								
								stat.bestStreak = calc.bestStreak(currentStreak: stat.currentStreak, bestStreak: stat.bestStreak)
								overallStat.bestStreak = calc.bestStreak(currentStreak: overallStat.currentStreak,
																												 bestStreak: overallStat.bestStreak)
								
								if didPassRound {
										newBestTime = calc.newBestTime(currentTime: currentGame.elapsedTime, bestTime: stat.bestTime)
										
										stat.bestTime = calc.bestTime(currentTime: currentGame.elapsedTime, bestTime: stat.bestTime)
										stat.bestTimeString = format.time(elapsedTime: stat.bestTime)
								}
								
								stat.averageTime = calc.averageTime(gamesPlayed: stat.gamesPlayed, totalTime: stat.totalTime)
								stat.averageTimeString = format.time(elapsedTime: stat.averageTime)
								overallStat.averageTime = calc.averageTime(gamesPlayed: overallStat.gamesPlayed,
																													 totalTime: overallStat.totalTime)
								overallStat.averageTimeString = format.time(elapsedTime: overallStat.averageTime)
						}
						
						// Check if any difficulty achievements were earned
						for group in sortedGroups {
								for goal in group.goals {
										if check.isComplete(group: group, goal: goal) {
												if goal.isComplete == false {
														newAchievements.append(NewAchievement(difficulty: currentGame.difficulty.rawValue, group: group, goal: goal))
												}
												
												goal.isComplete = true
										}
								}
						}
						
						// Check if any overall achievements were earned
						for group in sortedOverallGroups {
								for goal in group.goals {
										if check.isComplete(group: group, goal: goal) {
												if goal.isComplete == false {
														newAchievements.append(NewAchievement(difficulty: "Overall", group: group, goal: goal))
												}
												
												goal.isComplete = true
										}
								}
						}
						
						// Difficulty Stats Updated
						//								TelemetryDeck.signal(
						//										"roundPlayed",
						//										parameters: [
						//												"difficulty": "\(stat.difficulty)",
						//												"gamesPlayed": "\(stat.gamesPlayed)",
						//												"gamesWon": "\(stat.gamesWon)",
						//												"perfectGames": "\(stat.perfectGames)",
						//												"highScore": "\(stat.highScore)",
						//												"averageScore": "\(stat.averageScore)",
						//												"percentCorrect": "\(stat.percentCorrect)",
						//												"correctTaps": "\(stat.correctTaps)",
						//												"totalTaps": "\(stat.totalTaps)",
						//												"accuracy": "\(stat.accuracy)",
						//												"currentStreak": "\(stat.currentStreak)",
						//												"bestStreak": "\(stat.bestStreak)",
						//												"totalTime": "\(stat.totalTime)",
						//												"bestTime": "\(stat.bestTime)",
						//												"bestTime String": "\(stat.bestTimeString)",
						//												"bestTime Tap Ratio": "\(stat.bestTimeTapRatio)",
						//												"bestTime Tap Ratio String": "\(stat.bestTimeTapRatioString)",
						//												"averageTime Tap Ratio": "\(stat.avgTimeTapRatio)",
						//												"averageTime Tap Ratio String": "\(stat.avgTimeTapRatioString)",
						//												"averageTime": "\(stat.averageTime)",
						//												"averageTime String": "\(stat.averageTimeString)"
						//										]
						//								)
				} else {
						print("Error: Returned more than 1 stat difficulty or overall stat")
				}
		}
}

struct NewAchievement: Identifiable {
		internal var id: UUID = UUID()
		var difficulty: String
		var group: GroupModel
		var goal: Goal
}
