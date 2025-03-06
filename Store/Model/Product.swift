//
//  Categorie.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import Foundation

struct Product: Identifiable, Codable {
    let id: String
    let category: String
    let url: String
    let name: String
    let price: Double
    let description: String
    let createdAt: Date = Date()
    

    enum CodingKeys: CodingKey {
        case id
        case category
        case url
        case name
        case price
        case description
        case createdAt
    }
}
