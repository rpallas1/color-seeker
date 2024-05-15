//
//  SettingsView.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/15/24.
//

import SwiftUI

struct SettingsView: View {
		
		@Environment(\.dismiss) private var dismiss
		
		@State var haptics = false
		@State var darkMode = false
		@State var showHowTo = false
		
    var body: some View {
				NavigationStack {
						VStack {
								Form {
										Section {
												HStack {
														Text("How to Play")
														Spacer()
														Button(action: {
																showHowTo = true
														}, label: {
																Image(systemName: "chevron.right")
														})
												}
												Toggle("Dark Mode", isOn: $haptics)
												Toggle("Haptics", isOn: $darkMode)
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
						.sheet(isPresented: $showHowTo, content: {
								HowToPlayView()
						})
				}
    }
}

#Preview {
    SettingsView()
}
