//
//  ProductsSection.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import SwiftUI


struct ProductView: View {
    @StateObject private var viewModel = ProductViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var didAppear = false
    
    let columns = [
           GridItem(.adaptive(minimum: 150))
       ]
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack(alignment: .leading) {
                    Text("Produits récents")
                        .font(.title2).padding(.horizontal)
                    
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible()),
                        ], spacing: 20 ) {
                            ForEach(viewModel.recentProduct) { item in
                                ProductRow(product: item)
                            }
                        }
                       // .padding(.horizontal)
                        .padding(.leading)
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
//            if !didAppear {
//                viewModel.fetchProduct()
//                didAppear = true
//            }
            
        }
    }
    
}

struct ProductRow: View {
    let product: Product
    @StateObject private var cartViewModel = CartViewModel()
    var body: some View {
        
        NavigationLink(destination: ProductDetailView(product: product)){
            
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: product.url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 170, height: 112)
                            
                            
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(10)
                    
                    // Informations du produit
                    VStack(alignment: .leading, spacing: 8) {
                        
                        Text(product.name)
                            .font(.subheadline)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.primary)
                        
                        Text("\(String(format: "%.2f", product.price)) €")
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal, 12)
                    
                    Button(action: {
                        cartViewModel.addToCart(product: product)
                    }) {
                        
                        Text("Ajouter au panier")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                            .background(AppColors.primary)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 12)
                    
                    .padding(.bottom, 12)
                }
                    .alert(isPresented: $cartViewModel.showAlert) { // Alerte pour informer l'utilisateur
                        Alert(title: Text("Information"), message: Text(cartViewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                    //.padding(.horizontal, 12)
                    //.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    //.padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    //.padding(.horizontal)
            }
           
        }

}


struct ProductRowDemo: View {
    let product: Product
    @StateObject private var cartViewModel = CartViewModel()
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Carte principale
            VStack(alignment: .leading, spacing: 12) {
                // Image du produit
                AsyncImage(url: URL(string: product.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ZStack {
                        Color.gray.opacity(0.1)
                        ProgressView()
                            .tint(Color.gray)
                    }
                }
                .frame(height: 180)
                .clipped()
                .cornerRadius(12)
                
                // Informations du produit
                VStack(alignment: .leading, spacing: 8) {
                    Text(product.name)
                        .font(.system(size: 16, weight: .medium))
                        .lineLimit(2)
                        .foregroundColor(colorScheme == .dark ? .white : .black)
                    
                    Text("\(String(format: "%.2f", product.price)) €")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.primary)
                    
                    Spacer(minLength: 40) // Espace pour le bouton
                }
                .padding(.horizontal, 12)
            }
            .padding(12)
            .background(colorScheme == .dark ? Color(.systemGray6) : Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            
            // Bouton d'ajout au panier
            Button(action: {
                withAnimation(.spring()) {
                    cartViewModel.addToCart(product: product)
                }
            }) {
                HStack {
                    Image(systemName: "cart.badge.plus")
                        .font(.system(size: 14))
                    Text("Ajouter au panier")
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(AppColors.primary)
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.horizontal, 24)
            .padding(.bottom, 16)
        }
        .alert(isPresented: $cartViewModel.showAlert) {
            Alert(
                title: Text("Produit ajouté"),
                message: Text(cartViewModel.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        // Utilisation d'un NavigationLink invisible pour la navigation
        .overlay(
            NavigationLink(destination: ProductDetailView(product: product)) {
                Rectangle()
                    .fill(Color.clear)
            }
            .opacity(0)
        )
    }
}
