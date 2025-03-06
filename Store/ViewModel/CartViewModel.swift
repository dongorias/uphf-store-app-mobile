//
//  CartViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import Foundation

@MainActor
class CartViewModel : ObservableObject {
    private let repository: CartRepository
    @Published var cartItems: [Cart] = []
    @Published var total: Double = 0
    @Published var isLoading = false
    @Published var alertMessage = ""
    @Published var showAlert = false
    
    init(repository: CartRepository = LocalCartRepository()) {
        self.repository = repository
        loadCart()
    }
    
    func loadCart() {
        cartItems = repository.getCarts()
        calculateTotal()
    }
    
    func addToCart(product: Product, quantity: Int = 1) {
        isLoading = true
        let added = repository.addToCart(product: product, quantity: quantity)
        loadCart()
        isLoading = false
        
        if !added {
                // Informer l'utilisateur que le produit est déjà dans le panier
                DispatchQueue.main.async {
                    self.alertMessage = "Ce produit est déjà dans le panier."
                    self.showAlert = true
                }
        }else{
            // Informer l'utilisateur que le produit est déjà dans le panier
            DispatchQueue.main.async {
                self.alertMessage = "Produit ajouté dans le panier."
                self.showAlert = true
            }
        }
    }
    
    func removeFromCart(productId: String) {
        repository.removeFromCart(productId: productId)
        loadCart()
    }
    
    func updateQuantity(productId: String, quantity: Int) {
        
        repository.updateQuantity(productId: productId, quantity: quantity)
        loadCart()
    }
    
    func clearCart() {
        repository.clearCart()
        loadCart()
    }
    
    private func calculateTotal() {
        total = cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }
}
