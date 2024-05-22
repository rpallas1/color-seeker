//
//  CustomSegmentedControlView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/21/24.
//

import SwiftUI

struct CustomSegmentedControlView: View {
		
		@Binding var selectedTab: Int
		let segments: [StatModel]
		
    var body: some View {
				ScrollViewReader { proxy in
						ScrollView(.horizontal) {
								HStack (spacing: 36) {
										ForEach(0..<segments.count, id: \.self) { index in
												Text(segments[index].difficulty)
														.foregroundStyle(selectedTab == index ? Color.cyan : Color("Primary Black"))
														.bold()
														.onTapGesture {
																withAnimation {
																		selectedTab = index
																		proxy.scrollTo(selectedTab, anchor: .center)
																}
														}
										}
								}
								.padding([.top, .horizontal])
						}
						.scrollIndicators(.hidden)
						.onChange(of: selectedTab) { oldValue, newValue in
								withAnimation {
										proxy.scrollTo(newValue, anchor: .center)
								}
						}
				}
    }
}
