//
//  HowToPlayView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct HowToPlayView: View {
		
		@Environment(\.dismiss) private var dismiss
		
    var body: some View {
				NavigationStack {
						VStack (spacing: 36) {
								Spacer()
								
								Text("Tap the color that's different")
								Text("See how fast you can complete a round")
								Text("Get at least 80% correct to complete a round")
								Text("The harder the difficulty, the more similar the colors are")
								
								ZStack {
										Grid {
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
																.opacity(0.5)
												}
												
												GridRow {
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
														RoundedRectangle(cornerRadius: 12)
																.frame(width: 136, height: 136)
												}
										}
										.foregroundStyle(.mint)
										
										VStack {
												HStack {
														Spacer()
														Image(systemName: "arrow.turn.left.down")
																.font(Font.system(size: 80))
																.padding(.trailing, 80)
												}
												Spacer()
										}
								}
								
								Spacer()
						}
						.navigationTitle("How to Play")
						.navigationBarTitleDisplayMode(.inline)
				}
    }
}

#Preview {
    HowToPlayView()
}
