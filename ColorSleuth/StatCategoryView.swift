//
//  StatCategory.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/16/24.
//

import SwiftUI
import SwiftData

struct StatCategoryView: View {
		
		var statCategory: StatCategory
		
    var body: some View {
				ScrollView {
						// List of stats
						VStack (spacing: 28) {
								ForEach(statCategory.sections) { section in
										StatGroupView(statSection: section)
								}
						}
				}
				.scrollIndicators(.hidden)
				.containerRelativeFrame(.horizontal)
    }
}
