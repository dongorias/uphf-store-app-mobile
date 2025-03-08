//
//  CheckoutViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

import Foundation
import Combine
import StripePaymentSheet
import FirebaseFirestore
import Alamofire
import SwiftUICore
import FirebaseAuth
import FirebaseAnalytics

@MainActor
class CheckoutViewModel: ObservableObject {
    @Published var paymentSheet: PaymentSheet?
    @Published var cartItems: [Cart] = []
    @Published var orders: [Order] = []
    @Published var totalAmount :Double?
    
    @Published var fullName: String = ""
    @Published var address: String = ""
    @Published var city: String = ""
    @Published var postalCode: String = ""
    
    private let db = Firestore.firestore()
    private let collection = "orders"
    
    let publishableKey = "pk_test_oKhSR5nslBRnBZpjO6KuzZeX"
    
    @Published var paymentResult: PaymentSheetResult?
    @Published var paymentIsCompleted = false
    @Published var orderIsCompleted = false
    @Published var paymentIsFailed = false
    @Published var paymentIsCancelled = false
    
    @Published var orderId: String = ""
    @Published var error = ""
    
    private var stripeRepository: StripeRepository
    private var authRepository: AuthRepository
    private var cartRepository: CartRepository
    private var checkoutRepository: CheckoutRepository
    
    
    var authViewModel: AuthViewModel?
     
     func setup(_ authViewModel: AuthViewModel) {
       self.authViewModel = authViewModel
     }
    
    init(
        stripRepository: StripeRepository = StripeRepositoryImpl(),
        authRepository: AuthRepository = FirebaseAuthRepository(),
        cartRepository: CartRepository = LocalCartRepository(),
        checkoutRepository: CheckoutRepository = FirestoreCheckoutRepository()
    ) {
        self.stripeRepository = stripRepository
        self.authRepository = authRepository
        self.cartRepository = cartRepository
        self.checkoutRepository = checkoutRepository
        
        fetchOrders()
        
        
    }
    
    func fetchOrders() {
        Task {
            if let uid = authViewModel?.user?.uid {
                self.orders = try await checkoutRepository.getOrders(uid)
                
            } 
            
        }
    }
    
    func getCarts() {
        self.cartItems =  cartRepository.getCarts()
        if(!self.cartItems.isEmpty){
            totalAmount = self.cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        }
    }
    
    func cleanCart() {
        self.cartRepository.clearCart()
    }
    
    func resetView() {
        self.orderIsCompleted = false
    }
    
    func preparePaymentSheet() {

        if let totalAmount, ((self.authViewModel?.customer) != nil) {
            
            STPAPIClient.shared.publishableKey = publishableKey
            
            let parameters = PaymentParameters(customer: self.authViewModel!.customer!.paymentId, amount: totalAmount * 100)
            
            self.stripeRepository.createPaymentIntent(postData: parameters) { result in
                switch result {
                case .success(let clientSecret):
                    var configuration = PaymentSheet.Configuration()
                    configuration.merchantDisplayName = "UPHF Store"
                    configuration.defaultBillingDetails.address.country = "FR"
                    configuration.paymentMethodOrder = ["card"]
                    DispatchQueue.main.async {
                        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: clientSecret, configuration: configuration)
                       
                    }
                    
                case .failure(let error):
                    print("error==>\(error)")
                    
                }
            }
        }
        
    }
    
    func submitOrder() {
        do{
            self.orderId = UUID().uuidString
            self.orderId = String(self.orderId[self.orderId.index(self.orderId.startIndex, offsetBy: 24)...])
            
            
            let order = Order(
                id:self.orderId,
                userId:self.authViewModel!.customer!.id, cart: self.cartItems,
                total: self.totalAmount!, statut: "En cours", statutPayment: "Payé", address: ShippingAddress(
                    fullName: self.fullName,
                    address: self.address,
                    city: self.city,
                    postalCode: self.postalCode
                )
            )
            
            try  db.collection(self.collection).document(self.orderId).setData(from: order) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    
                } else {
                    self.cleanCart()
                    self.orderIsCompleted = true
                    self.paymentSheet = nil
                }
            }
        } catch {
            print("Error encoding order: \(error.localizedDescription)")
        }
        
    }
    
    func onCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        
        switch result {
        case .completed:
            submitOrder()
        case .failed(let error):
            self.paymentIsFailed = true
            self.error = error.localizedDescription
            preparePaymentSheet()
        case .canceled:
            self.paymentIsCancelled = true
            preparePaymentSheet()
            
        }
        
    }
    
}
