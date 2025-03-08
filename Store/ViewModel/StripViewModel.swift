//
//  StripViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

import Foundation

@MainActor
class StripViewModel: ObservableObject {
    @Published var customerId: String = ""
    @Published var errorMessage: String = ""
    private var stripeRepository: StripeRepository
    
    init(repository: StripeRepository = StripeRepositoryImpl()) {
        self.stripeRepository = repository
        
    }
    
    func createCustomerPaymentId(completion: @escaping (Result<String, any Error>) -> Void) {
        stripeRepository.createCustomerPaymentId { result in
            switch result {
            case .success(let id):
                DispatchQueue.main.async {
                    //self.customerId = id
                    completion(.success(id))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                    
                }
            }
        }
    }
    
    func createPaymentIntent(postData: PaymentParameters, completion: @escaping (Result<String, any Error>) -> Void){
       
        stripeRepository.createPaymentIntent(postData: postData) { result in
            switch result {
            case .success(let id):
                DispatchQueue.main.async {
                    //self.paymentIntentId = id
                    completion(.success(id))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = "Error creating payment intent: \(error.localizedDescription)"
                    completion(.failure(error))
                }
            }
        }
    }
}
