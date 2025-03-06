//
//  Banner.swift
//  Store
//
//  Created by Don Arias Agokoli on 05/01/2025.
//

import Foundation

struct Banner: Identifiable, Codable {
    let id: Int
    let title: String
    let description: String

    enum CodingKeys: CodingKey {
        case id
        case title
        case description
    }
}
