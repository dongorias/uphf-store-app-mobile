//
//  CartRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

protocol CartRepository {
    func getCarts() -> [Cart]
    func addToCart(product: Product, quantity: Int)->Bool
    func removeFromCart(productId: String)
    func updateQuantity(productId: String, quantity: Int)
    func clearCart()
}
