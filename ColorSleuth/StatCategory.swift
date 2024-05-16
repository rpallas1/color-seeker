//
//  StatCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI

struct StatCategory: View {
    var body: some View {
				ScrollView {
						// List of stats
						VStack (spacing: 28) {
								StatGroup()
								StatGroup()
								StatGroup()
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}

#Preview {
    StatCategory()
}
