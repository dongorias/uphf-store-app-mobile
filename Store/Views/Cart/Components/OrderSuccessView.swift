//
//  OrderSuccessView.swift
//  Store
//
//  Created by Don Arias Agokoli on 21/02/2025.
//

import SwiftUI

struct OrderSuccessView: View {
    

    let orderId: String
    
    
    
    var onClose: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 32) {
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(AppColors.primary, lineWidth: 3)
                .frame(width: 80, height: 80)
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.top, 60)
            
            // Textes de confirmation
            VStack(spacing: 16) {
                Text("Commande confirmée !")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Merci pour votre commande")
                    .font(.title3)
                    .foregroundColor(.secondary)
                
                Text("N° \(orderId)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            
            //   Bouton de retour
            Button(action:{
               // checkoutViewModel.resetView()
               // tabMonitor.selectedTab = 1
                onClose?()
                
                
            }) {
                Text("Retour à l'accueil")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColors.primary)
                    .cornerRadius(10)
            }
            .padding()
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Preview
//struct OrderSuccessView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderSuccessView(orderId: "CMD-123456", shouldPopToRootView: false)
//    }
//}
