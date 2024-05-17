//
//  ConstantData.swift
//  ColorSleuth
//
//  Created by Ryan Pallas on 5/17/24.
//

import Foundation

struct StatCategory: Identifiable, Decodable {
		
		let id:UUID = UUID()
		var difficulty: String
		var sections: [StatSection]
}

struct StatSection: Identifiable, Decodable {
		
		let id:UUID = UUID()
		var name: String
		var stats: [StatGroup]
}

struct StatGroup: Identifiable, Decodable {
		
		let id:UUID = UUID()
		var name: String
		var stat: Int
}
