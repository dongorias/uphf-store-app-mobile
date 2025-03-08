//
//  CartView.swift
//  market
//
//  Created by Don Arias Agokoli on 23/12/2024.
//
import SwiftUI
import StripeCore
import PassKit

struct CartView: View {
    @StateObject private var cartViewModel = CartViewModel()
    //@StateObject private var authViewModel = AuthViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var deliveryInfoView: Bool = false

    
    var body: some View {
        
        VStack {
            if cartViewModel.cartItems.isEmpty {
                EmptyCartView()
            } else {
                List {
                    ForEach(cartViewModel.cartItems) { item in
                        CartItemRow(item: item, viewModel: cartViewModel)
                    }
                }
                
                
                CartSummary(
                    total: cartViewModel.total,
                    onOrder: {
                        
                        deliveryInfoView = true
                        
                        
                    },
                    onNotLoggedIn: {
                        authViewModel.navigateToAuthView = true
                    }
                )
            }
        }
        .alert(isPresented: $authViewModel.showAlert) { // Alerte pour informer l'utilisateur
            Alert(title: Text("Information"), message: Text(authViewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
        .sheet(isPresented: $authViewModel.navigateToAuthView, content: {
            AuthView().presentationDetents([.fraction(0.15)])
        })
        
        .navigationDestination(isPresented: $deliveryInfoView ) {
            DeliveryInfoView {
                self.deliveryInfoView = false
            }
        }
        .onAppear{
            cartViewModel.loadCart()
        }.refreshable {
            cartViewModel.loadCart()
        }
        .navigationTitle("Panier")
        
    }
}


struct CartItemRow: View {
    let item: Cart
    @ObservedObject var viewModel: CartViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: item.product.url)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(item.product.name)
                    .lineLimit(2)
                    .font(.headline)
                Text("\(String(format: "%.2f", item.product.price)) €")
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.updateQuantity(productId: item.product.id, quantity: item.quantity - 1)
                }) {
                    Image(systemName: "minus.circle")
                }.buttonStyle(BorderlessButtonStyle())
                
                Text("\(item.quantity)").frame(width: 30)
                
                Button(action: {
                    viewModel.updateQuantity(productId: item.product.id, quantity: item.quantity + 1)
                }) {
                    Image(systemName: "plus.circle")
                }.buttonStyle(BorderlessButtonStyle())
            }
        }
        .swipeActions(edge: .trailing) {
            Button(role: .destructive) {
                viewModel.removeFromCart(productId: item.product.id)
            } label: {
                Label("Supprimer", systemImage: "trash")
            }
        }
    }
}
