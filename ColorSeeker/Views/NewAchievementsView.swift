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
				VStack(alignment: .leading, spacing: 10) {
						HStack {
								Text(achievement.difficulty)
										.font(.title2)
										.bold()
								Spacer()
								Text("Complete")
										.foregroundStyle(.gray)
										.bold()
						}
						
						HStack(spacing: 8) {
								Image(systemName: "trophy.fill")
										.font(Font.system(size: 50))
										.foregroundStyle(.accent)
								Text(format.fullDescripiton(group: achievement.group, goal: achievement.goal))
										.font(.title2)
										.fixedSize(horizontal: false, vertical: true)
								Spacer()
						}
				}
				.frame(width: width * trailingPadding)
				.padding(.horizontal, 16)
				.padding(.vertical, 8)
				.background {
						RoundedRectangle(cornerRadius: 12)
								.foregroundStyle(Color("Primary Gray"))
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
