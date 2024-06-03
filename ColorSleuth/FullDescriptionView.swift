//
//  FullDescriptionView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 6/3/24.
//

import SwiftUI

struct FullDescriptionView: View {
		
		var group: GroupModel
		var goal: Goal
		var format = FormatHelper()

    var body: some View {
				VStack(spacing: 8) {
						Image(systemName: goal.isComplete ? "trophy.fill" : "trophy")
								.foregroundStyle(goal.isComplete ? .cyan : .gray)
								.font(Font.system(size: 100))
						Text(format.previewDescription(group: group, goal: goal))
								.font(.subheadline)
						Text(format.fullDescripiton(group: group, goal: goal))
								.font(.title3)
				}
				.multilineTextAlignment(.center)
    }
}
