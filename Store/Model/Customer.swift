//
//  Customer.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/02/2025.
//

import Foundation


struct Customer: Identifiable, Codable {
    let id: String
    let email: String
    let paymentId: String
    let name: String
    

    enum CodingKeys: CodingKey {
        case id
        case email
        case name
        case paymentId
    }
}
