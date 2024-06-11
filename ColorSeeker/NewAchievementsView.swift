//
//  NewAchievementsView.swift
//  ColorSeeker
//
//  Created by Ryan Pallas on 6/10/24.
//

import SwiftUI

struct NewAchievementsView: View {
		
		var achievement: NewAchievement
		var width: CGFloat
		var count: Int
		private var trailingPadding = 0.75
		private let format = FormatHelper()
		
    var body: some View {
				VStack(alignment: .leading, spacing: 8) {
						HStack {
								Text(achievement.difficulty)
										.font(.title2)
										.bold()
								Spacer()
						}
						
						HStack(spacing: 8) {
								Image(systemName: "trophy.fill")
										.font(Font.system(size: 50))
										.foregroundStyle(.accent)
								Text(format.fullDescripiton(group: achievement.group, goal: achievement.goal))
										.font(.title2)
								Spacer()
						}
				}
				.frame(width: width * trailingPadding)
				.padding([.vertical, .leading])
				.background {
						RoundedRectangle(cornerRadius: 12)
								.foregroundStyle(Color("Primary Gray"))
								.shadow(radius: 6)
				}
				.scrollTransition(axis: .horizontal) { content, phase in
						content
								.scaleEffect(
										x: phase.isIdentity ? 1.0 : 0.80,
										y: phase.isIdentity ? 1.0 : 0.80)
				}
    }
		
		init(achievement: NewAchievement, width: CGFloat, count: Int) {
				self.achievement = achievement
				self.width = width
				self.count = count
		}
}
