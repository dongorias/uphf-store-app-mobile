//
//  CartSummary.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import SwiftUI

import SwiftUI

struct CartSummary: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    let total: Double
    
    // Closures pour les actions
    var onOrder: () -> Void
    var onNotLoggedIn: () -> Void
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text("\(String(format: "%.2f", total)) €")
                    .font(.title2)
                    .bold()
            }
            .padding()
            
            // Action pour passer à la commande
            if authViewModel.authState == .signedIn {
                Button(action: {
                    onOrder()
                }) {
                    Text("Commander")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "67C4A7"))
                        .cornerRadius(10)
                }
                .padding()
            } else {
                Button(action: {
                    onNotLoggedIn()
                }) {
                    Text("Se connecter pour commander")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(hex: "67C4A7"))
                        .cornerRadius(10)
                }.padding()
            }
            
        }
        
        .background(Color(.systemBackground))
        .shadow(radius: 2)
    }
}

