//
//  SettingsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct SettingsView: View {
		
		@Environment(\.dismiss) private var dismiss
		@Environment(GlobalStates.self) var settings
		
    var body: some View {
				
				@Bindable var settings = settings
				
				NavigationStack {
						VStack {
								Form {
										Section() {
												HStack {
														Text("How to Play")
														Spacer()
														NavigationLink {
																HowToPlayView()
																		.presentationDragIndicator(.visible)
														} label: {}
												}
												Toggle("Dark Mode", isOn: $settings.darkMode)
												Toggle("Haptics", isOn: $settings.haptics)
										}
										
										Section {
												Button("Reset Data") {
														// TODO: Confirm deletion
												}
												.foregroundStyle(.red)
										}
								}
						}
						.navigationTitle("Settings")
						.navigationBarTitleDisplayMode(.inline)
						.toolbar {
								Button(action: {
										dismiss()
								}, label: {
										Text("Done")
												.bold()
								})
						}
				}
    }
}

#Preview {
    SettingsView()
}
