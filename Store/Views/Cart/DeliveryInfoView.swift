//
//  DeliveryInfoView.swift
//  Store
//
//  Created by Don Arias Agokoli on 14/02/2025.
//
import SwiftUI
import StripePaymentSheet


struct DeliveryInfoView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var navigateToAuth: Bool = false
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var checkoutViewModel = CheckoutViewModel()
    @StateObject private var cartViewModel = CartViewModel()
    
    @State private var isValidated = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack(spacing: 20){
                
                
                TextField("Nom Complet", text: $checkoutViewModel.fullName)
                    .onChange(of: checkoutViewModel.fullName) {
                        updateValidation()
                    }
                
                TextField("Adresse", text: $checkoutViewModel.address)
                    .onChange(of: checkoutViewModel.address) {
                        updateValidation()
                    }
                
                TextField("Ville", text: $checkoutViewModel.city)
                    .onChange(of: checkoutViewModel.city) {
                        updateValidation()
                    }
                
                TextField("Code Postal", text: $checkoutViewModel.postalCode)
                    .onChange(of: checkoutViewModel.postalCode) {
                        updateValidation()
                    }
                
                
            }
            .padding()
            .disableAutocorrection(true)
            .textFieldStyle(.roundedBorder)
            
            
            Spacer()
            
            if isValidated, let paymentSheet = checkoutViewModel.paymentSheet {
                PaymentSheet.PaymentButton(
                    paymentSheet: paymentSheet,
                    onCompletion: checkoutViewModel.onCompletion
                ) {
                    
                    Text("Commander et payer")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(AppColors.primary)
                        .cornerRadius(10)
                        .padding()
                }
            } else {
                Text("Commander et payer")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background((isValidated && checkoutViewModel.paymentSheet != nil) ? AppColors.primary : .gray)
                    .cornerRadius(10)
                    .padding()
            }
            
            
            
            
        }
        .onAppear {
            
            self.checkoutViewModel.setup(self.authViewModel)
            checkoutViewModel.getCarts()
            checkoutViewModel.preparePaymentSheet()
            
        }
        .toolbar(.hidden, for: .tabBar)
        .background(Color(.systemBackground))
        .navigationBarTitle("Livraison", displayMode: .inline)
        
        .navigationDestination(isPresented: $checkoutViewModel.orderIsCompleted){
            OrderSuccessView(orderId: checkoutViewModel.orderId).navigationBarBackButtonHidden()
        }
    }
    
    private func updateValidation() {
        isValidated = !checkoutViewModel.fullName.isEmpty &&
        !checkoutViewModel.address.isEmpty &&
        !checkoutViewModel.city.isEmpty &&
        !checkoutViewModel.postalCode.isEmpty
    }
}



