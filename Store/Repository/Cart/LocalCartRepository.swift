//
//  LocalCartRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import Foundation

class LocalCartRepository: CartRepository {
    private let userDefaults = UserDefaults.standard
    private let cartKey = "cart_items"
    
    func getCarts() -> [Cart] {
        guard let data = userDefaults.data(forKey: cartKey),
              let carts = try? JSONDecoder().decode([Cart].self, from: data) else {
            return []
        }
        return carts
    }
    
    func addToCart(product: Product, quantity: Int) -> Bool{
        var currentCarts = getCarts()
        
        if let index = currentCarts.firstIndex(where: { $0.product.id == product.id }) {
            currentCarts[index].quantity += quantity
            return false // Produit déjà dans le panier
        } else {
            let cart = Cart(id: UUID().uuidString, product: product, quantity: quantity)
            currentCarts.append(cart)
            saveCart(items: currentCarts)
            return true // Produit ajouté avec succès
        }
    
    }
    
    func removeFromCart(productId: String) {
        var currentCarts = getCarts()
        currentCarts.removeAll { $0.product.id == productId }
        saveCart(items: currentCarts)
    }
    
    func updateQuantity(productId: String, quantity: Int) {
        var currentCarts = getCarts()
        if let index = currentCarts.firstIndex(where: { $0.product.id == productId }) {
            currentCarts[index].quantity = max(1, quantity) // Empêche les quantités négatives
        }
        saveCart(items: currentCarts)
    }
    
    func clearCart() {
        saveCart(items: [])
    }
    
    private func saveCart(items: [Cart]) {
        if let encoded = try? JSONEncoder().encode(items) {
            userDefaults.set(encoded, forKey: cartKey)
        }
    }
}
