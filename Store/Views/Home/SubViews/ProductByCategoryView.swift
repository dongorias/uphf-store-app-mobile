//
//  ProduitByCategorie.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import SwiftUI

struct ProductByCategoryView: View {
    let categoryId: String
    @StateObject private var viewModel = ProductViewModel()
    
    var body: some View {
        
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                ScrollView {
                    if viewModel.productByCategory.isEmpty {
                        
                        VStack {
                            Spacer(minLength: 100)
                            
                            VStack(spacing: 20) {
                                Image(systemName: "cart.badge.minus")
                                    .font(.system(size: 50))
                                    .foregroundColor(.gray)
                                
                                Text("Aucun produit disponible")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            
                            Spacer(minLength: 100)
                        }
                        .frame(minHeight: UIScreen.main.bounds.height - 300)
                    } else {
                        // Grille de produits
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 20) {
                            ForEach(viewModel.productByCategory) { item in
                                ProductRow(product: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .alert("Erreur", isPresented: Binding(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )) {
            Text(viewModel.error?.localizedDescription ?? "")
        }
        .onAppear {
            viewModel.fetchProductByCategory(categoryId)
        }
    }
}
