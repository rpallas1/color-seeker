//
//  DataService.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation

struct DataService {
		
		func getFileData() -> [StatCategory] {
				// Get file path to StatCategories.json
				if let url = Bundle.main.url(forResource: "StatCategories", withExtension: "json") {
						
						do {
								// Read the file and turn it into Data
								let data = try Data(contentsOf: url)
								
								// Parse data into Swift instances
								let decoder = JSONDecoder()
								
								do {
										let sections = try decoder.decode([StatCategory].self, from: data)
										return sections
								} catch {
										print("Couldn't decode: \(error)")
								}
						} catch {
								print("Couldn't read the file: \(error)")
						}
				}
				
				return [StatCategory]()
		}
}
