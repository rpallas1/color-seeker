//
//  AchievementSet.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct AchievementGroupView: View {
		
		var section: String
		var description1: String
		var description2: String
		var description3: String
		var description4: String
		var description5: String
		var description6: String
		
    var body: some View {
				VStack (alignment: .leading, spacing: 20) {
						Text(section)
								.font(.title)
								.bold()
						HStack {
								VStack (spacing: 8) {
										Image(systemName: "trophy.fill")
												.foregroundStyle(.cyan)
												.font(Font.system(size: 50))
										Text(description1)
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy.fill")
												.foregroundStyle(.cyan)
												.font(Font.system(size: 50))
										Text(description2)
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text(description3)
								}
						}
						.padding(.horizontal, 24)
						
						HStack {
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text(description4)
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text(description5)
								}
								Spacer()
								VStack (spacing: 8) {
										Image(systemName: "trophy")
												.foregroundStyle(.gray)
												.font(Font.system(size: 50))
										Text(description6)
								}
						}
						.padding(.horizontal, 24)
				}
				.padding(.top)
				.multilineTextAlignment(.center)
    }
}
