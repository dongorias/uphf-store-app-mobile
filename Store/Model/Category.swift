//
//  Categorie.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import Foundation

struct Category: Identifiable, Codable {
    let id: String
    let image: String
    let name: String
    let color: String

    enum CodingKeys: CodingKey {
        case id
        case image
        case name
        case color
    }
}
