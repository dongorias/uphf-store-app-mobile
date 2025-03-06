//
//  EmptyCartView.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//
import SwiftUI
struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Votre panier est vide")
                .font(.title2)
                .bold()
            
            Text("Ajoutez des articles à votre panier pour commencer vos achats")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
