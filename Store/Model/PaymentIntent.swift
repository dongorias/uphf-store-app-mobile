//
//  PaymentIntent.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

struct PaymentIntent: Codable {
    let clientSecret: String
    
    enum CodingKeys: String, CodingKey {
        case clientSecret = "client_secret"
    }
}
