//
//  StatCard.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct StatGroup: View {
		
//		var stat: Stat
		var section: String
		var firstStatName: String
		var firstStat: String
		var secondStatName: String
		var secondStat: String
		
		var body: some View {
				VStack (alignment: .leading, spacing: 20) {
						Text(section)
								.font(.title)
								.bold()
						
						HStack {
								Text(firstStatName)
										.padding(.leading)
								Spacer()
								Text(String(firstStat))
						}
						.padding()
						.font(.title3)
						.background {
								RoundedRectangle(cornerRadius: 15)
										.foregroundStyle(Color("Primary Gray"))
						}
						
						HStack {
								Text(secondStatName)
										.padding(.leading)
								Spacer()
								Text(secondStat)
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
}
