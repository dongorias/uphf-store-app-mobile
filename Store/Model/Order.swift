//
//  Order.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/02/2025.
//

import Foundation
import FirebaseFirestore

struct Order: Identifiable, Codable {
    let id: String?
    let userId: String
    let cart: [Cart]
    let total: Double
    let statut: String
    let statutPayment: String
    let address: ShippingAddress
    let createdAt: Date = Date()
    

    enum CodingKeys: String, CodingKey {
        case id
        case userId
        case cart
        case address
        case statut
        case statutPayment
        case total
        case createdAt
    }
    
    var dictionary: [String: Any] {
        return [
            "userId": userId,
            "cart": cart,
            "total": total,
            "statut": statut,
            "statutPayment": statutPayment,
            "address": address
        ]
    }
    
    // Initialiseur avec valeurs par défaut
//        init(
//            id: String?,
//            userId: String,
//            cart: [Cart],
//            total: Double,
//            statut: String,
//            statutPayment: String,
//            address: ShippingAddress
//        ) {
//            self.id = id
//            self.userId = userId
//            self.cart = cart
//            self.total = total
//            self.statut = statut
//            self.statutPayment = statutPayment
//            self.address = address
//        }
}
