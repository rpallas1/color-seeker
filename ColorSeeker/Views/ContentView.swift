//
//  ContentView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import Foundation
import SwiftUI
import SwiftData
import TelemetryDeck

struct ContentView: View {
		
		@Environment(\.modelContext) private var context
		@Environment(\.scenePhase) private var scenePhase
		@Environment(\.colorScheme) var deviceColorScheme
		@Environment(Settings.self) var settings
		@Environment(GlobalStates.self) var globalStates
		
		@Query private var allStats: [StatModel]
		@Query private var allAchievements: [AchievementModel]
		@Query(sort: \StatModel.index)
		private var sortedStats: [StatModel]
		@State var selection = Tabs.home
		@State private var showSettings = false
		
		// Define state property for the context to be passed outside of a view
		@State private var defaultData: DefaultDataHelper?
		
		var body: some View {
				NavigationStack {
						TabView(selection: $selection) {
								HomeView()
										.tabItem {
												Label("Home", systemImage: "house")
										}
										.tag(Tabs.home)
								
								StatsView()
										.tabItem {
												Label("Stats", systemImage: "chart.bar.xaxis")
										}
										.tag(Tabs.stats)
								
								AchievementsView()
										.tabItem {
												Label("Achievements", systemImage: "trophy")
										}
										.tag(Tabs.achievements)
						}
						.navigationTitle(selection.rawValue == "home" ? "" : selection.rawValue.capitalized)
						.navigationBarTitleDisplayMode(.inline)
						.navigationBarBackButtonHidden()
						.onChange(of: scenePhase, { oldPhase, newPhase in
								if newPhase == .background {
										globalStates.sentAnalytics = false
								}
						})
						.onAppear {
								defaultData = DefaultDataHelper(context: context)
								
								if !globalStates.sentAnalytics {
										TelemetryDeck.signal("userData", parameters: setSignalData())
								}
								
								if allStats.count == 0 && allAchievements.count == 0 {
										defaultData!.initStats()
										defaultData!.initAchievemnets()
//										print(context.sqliteCommand)
								} else {
										// TODO: Delete and re-init achievements for on-device
//										print(context.sqliteCommand)
								}
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
				})
		}
		
		func setSignalData() -> [String: String] {
				let overallStat = sortedStats[0]
				let easyStat = sortedStats[1]
				let mediumStat = sortedStats[2]
				let hardStat = sortedStats[3]
				let extremeStat = sortedStats[4]
				let survivalStat = sortedStats[5]

				var preferredColorScheme: String {
						switch settings.colorScheme {
						case .light:
								return "Light Mode"
						case .dark:
								return "Dark Mode"
						case .system:
								return "Using System Color Scheme"
						}
				}
				var systemColorScheme: String {
						switch deviceColorScheme {
						case .light:
								return "Light Mode"
						case .dark:
								return "Dark Mode"
						@unknown default:
								return "Unknown Device Color Scheme"
						}
				}
		
				let signal: [String : String] = ["overall-games-played": "\(overallStat.gamesPlayed)",
																				 "overall-games-won": "\(overallStat.gamesWon)",
																				 "overall-perfect-games": "\(overallStat.perfectGames)",
																				 "overall-percent-correct": "\(overallStat.percentCorrect)",
																				 "overall-correct-taps": "\(overallStat.correctTaps)",
																				 "overall-total-taps": "\(overallStat.totalTaps)",
																				 "overall-accuracy": "\(overallStat.accuracy)",
																				 "overall-current-streak": "\(overallStat.currentStreak)",
																				 "overall-best-streak": "\(overallStat.bestStreak)",
																				 "overall-total-time": "\(overallStat.totalTime)",
																				 "overall-average-time": "\(overallStat.averageTime)",
																				 "overall-average-time-string": "\(overallStat.averageTimeString)",
																				 "easy-games-played": "\(easyStat.gamesPlayed)",
																				 "easy-games-won": "\(easyStat.gamesWon)",
																				 "easy-perfect-games": "\(easyStat.perfectGames)",
																				 "easy-percent-correct": "\(easyStat.percentCorrect)",
																				 "easy-correct-taps": "\(easyStat.correctTaps)",
																				 "easy-total-taps": "\(easyStat.totalTaps)",
																				 "easy-accuracy": "\(easyStat.accuracy)",
																				 "easy-current-streak": "\(easyStat.currentStreak)",
																				 "easy-best-streak": "\(easyStat.bestStreak)",
																				 "easy-total-time": "\(easyStat.totalTime)",
																				 "easy-best-time": "\(easyStat.bestTime)",
																				 "easy-best-time-string": "\(easyStat.bestTimeString)",
																				 "easy-average-time": "\(easyStat.averageTime)",
																				 "easy-average-time-string": "\(easyStat.averageTimeString)",
																				 "medium-games-played": "\(mediumStat.gamesPlayed)",
																				 "medium-games-won": "\(mediumStat.gamesWon)",
																				 "medium-perfect-games": "\(mediumStat.perfectGames)",
																				 "medium-percent-correct": "\(mediumStat.percentCorrect)",
																				 "medium-correct-taps": "\(mediumStat.correctTaps)",
																				 "medium-total-taps": "\(mediumStat.totalTaps)",
																				 "medium-accuracy": "\(mediumStat.accuracy)",
																				 "medium-current-streak": "\(mediumStat.currentStreak)",
																				 "medium-best-streak": "\(mediumStat.bestStreak)",
																				 "medium-total-time": "\(mediumStat.totalTime)",
																				 "medium-best-time": "\(mediumStat.bestTime)",
																				 "medium-best-time-string": "\(mediumStat.bestTimeString)",
																				 "medium-average-time": "\(mediumStat.averageTime)",
																				 "medium-average-time-string": "\(mediumStat.averageTimeString)",
																				 "hard-games-played": "\(hardStat.gamesPlayed)",
																				 "hard-games-won": "\(hardStat.gamesWon)",
																				 "hard-perfect-games": "\(hardStat.perfectGames)",
																				 "hard-percent-correct": "\(hardStat.percentCorrect)",
																				 "hard-correct-taps": "\(hardStat.correctTaps)",
																				 "hard-total-taps": "\(hardStat.totalTaps)",
																				 "hard-accuracy": "\(hardStat.accuracy)",
																				 "hard-current-streak": "\(hardStat.currentStreak)",
																				 "hard-best-streak": "\(hardStat.bestStreak)",
																				 "hard-total-time": "\(hardStat.totalTime)",
																				 "hard-best-time": "\(hardStat.bestTime)",
																				 "hard-best-time-string": "\(hardStat.bestTimeString)",
																				 "hard-average-time": "\(hardStat.averageTime)",
																				 "hard-average-time-string": "\(hardStat.averageTimeString)",
																				 "extreme-games-played": "\(extremeStat.gamesPlayed)",
																				 "extreme-games-won": "\(extremeStat.gamesWon)",
																				 "extreme-perfect-games": "\(extremeStat.perfectGames)",
																				 "extreme-percent-correct": "\(extremeStat.percentCorrect)",
																				 "extreme-correct-taps": "\(extremeStat.correctTaps)",
																				 "extreme-total-taps": "\(extremeStat.totalTaps)",
																				 "extreme-accuracy": "\(extremeStat.accuracy)",
																				 "extreme-current-streak": "\(extremeStat.currentStreak)",
																				 "extreme-best-streak": "\(extremeStat.bestStreak)",
																				 "extreme-total-time": "\(extremeStat.totalTime)",
																				 "extreme-best-time": "\(extremeStat.bestTime)",
																				 "extreme-best-time-string": "\(extremeStat.bestTimeString)",
																				 "extreme-average-time": "\(extremeStat.averageTime)",
																				 "extreme-average-time-string": "\(extremeStat.averageTimeString)",
																				 "survival-games-played": "\(survivalStat.gamesPlayed)",
																				 "survival-high-score": "\(survivalStat.highScore)",
																				 "survival-average-score": "\(survivalStat.averageScore)",
																				 "survival-percent-correct": "\(survivalStat.percentCorrect)",
																				 "survival-correct-taps": "\(survivalStat.correctTaps)",
																				 "survival-total-taps": "\(survivalStat.totalTaps)",
																				 "survival-total-time": "\(survivalStat.totalTime)",
																				 "survival-best-time": "\(survivalStat.bestTime)",
																				 "survival-best-time-string": "\(survivalStat.bestTimeString)",
																				 "survival-best-time-tap-ratio": "\(survivalStat.bestTimeTapRatio)",
																				 "survival-best-time-tap-ratio-string": "\(survivalStat.bestTimeTapRatioString)",
																				 "survival-avg-time-tap-ratio": "\(survivalStat.avgTimeTapRatio)",
																				 "survival-avg-time-tap-ratio-string": "\(survivalStat.avgTimeTapRatioString)",
																				 "survival-average-time": "\(survivalStat.averageTime)",
																				 "survival-average-time-string": "\(survivalStat.averageTimeString)",
																				 "color-scheme-system": "\(systemColorScheme)",
																				 "color-scheme-preferred": "\(preferredColorScheme)"
																				]
				
				globalStates.sentAnalytics = true

				return signal
		}
}

enum Tabs: String {
		case home
		case stats
		case achievements
}
