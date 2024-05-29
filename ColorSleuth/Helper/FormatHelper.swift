//
//  FormatHelper.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/27/24.
//

import Foundation

struct FormatHelper {

		func percent(percent: Double) -> String {
				if percent.truncatingRemainder(dividingBy: 1) == 0 {
						return String(format: "%.0f%%", percent)
				} else {
						return String(format: "%.1f%%", percent)
				}
		}
		
		func time(elapsedTime: Double) -> String {
				if elapsedTime < 60 {
						let roundedElapsedTime = (elapsedTime * 10).rounded() / 10
						let tenthsPlace = Int((roundedElapsedTime * 10).truncatingRemainder(dividingBy: 10))
						if tenthsPlace == 0 {
								return String(format: "%.0fs", elapsedTime)
						} else {
								return String(format: "%.1fs", elapsedTime)
						}						
				} else {
						let minutes = Int(elapsedTime) / 60
						let seconds = Int(elapsedTime) % 60
						return String(format: "%02d:%02d", minutes, seconds)
				}
		}
}
