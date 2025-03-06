//
//  Cart.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

struct Cart: Identifiable, Codable {
    let id: String
    let product: Product
    var quantity: Int
}
