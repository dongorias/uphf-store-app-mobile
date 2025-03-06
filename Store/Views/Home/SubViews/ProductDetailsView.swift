//
//  ProductDetails.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//
import SwiftUI

struct ProductDetailView: View {
    let product: Product
    
    @StateObject private var cartViewModel = CartViewModel()
    @State private var isLoading = false
    
    var body: some View {
       
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image du produit
                AsyncImage(url: URL(string: product.url)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack {
                            Color.clear // Pour s'assurer que le ZStack a une taille
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity) // Prendre toute la place disponible
                        }
                }
                .frame(maxWidth: .infinity)
                
                // Informations du produit
                VStack(alignment: .leading, spacing: 12) {
                    Text(product.name)
                        .font(.title2)
                        .bold()
                    
                    Text("\(String(format: "%.2f", product.price)) €")
                        .font(.title3)
                        .bold()
                    
                    Text(product.description)
                        .foregroundColor(.gray)

                    // Bouton Add to cart
                    Button(action: {
                        cartViewModel.addToCart(product: product)
                    }) {
                        if(cartViewModel.isLoading){
                            ProgressView()
                        }else{
                            Text("Ajouter au panier")
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(AppColors.primary)
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding(.top)
                    .alert(isPresented: $cartViewModel.showAlert) { // Alerte pour informer l'utilisateur
                        Alert(title: Text("Information"), message: Text(cartViewModel.alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
            }
        }
        
        .navigationBarTitleDisplayMode(.inline)
    }
}
