//
//  StatCard.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct StatGroup: View {
		var body: some View {
				VStack (alignment: .leading, spacing: 20) {
						Text("Games")
								.font(.title)
								.bold()
						
						HStack {
								Text("Games Played")
										.padding(.leading)
								Spacer()
								Text("196")
						}
						.padding()
						.font(.title3)
						.background {
								RoundedRectangle(cornerRadius: 15)
										.foregroundStyle(Color("Primary Gray"))
						}
						
						HStack {
								Text("Percent Correct")
										.padding(.leading)
								Spacer()
								Text("100%")
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

#Preview {
		StatGroup()
}
