//
//  StatCard.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct StatGroupView: View {
		
		var statSection: StatSection
		
		var body: some View {
				VStack (alignment: .leading, spacing: 20) {
						Text(statSection.name)
								.font(.title)
								.bold()
						
						ForEach(statSection.stats) { group in
								HStack {
										Text(group.name)
												.padding(.leading)
										Spacer()
										Text(String(group.stat))
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
		}
}
