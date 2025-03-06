//
//  ShippingAddress.swift
//  Store
//
//  Created by Don Arias Agokoli on 19/02/2025.
//

struct ShippingAddress: Codable {
    let fullName: String
    let address: String
    let city: String
    let postalCode: String
    

    enum CodingKeys: CodingKey {
        case fullName
        case address
        case city
        case postalCode
    }
}


