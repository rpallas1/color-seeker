//
//  AchievementCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementCategory: View {
    var body: some View {
				ScrollView {
						// List of achievements
						VStack {
								AchievementGroup()
								Divider()
										.padding(.leading)
								AchievementGroup()
								Divider()
										.padding(.leading)
								AchievementGroup()
								Divider()
										.padding(.leading)
								AchievementGroup()
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}

#Preview {
    AchievementCategory()
}
