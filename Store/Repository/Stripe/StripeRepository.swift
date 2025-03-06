//
//  StripRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

protocol StripeRepository {
    
    func createCustomerPaymentId(completion: @escaping (Result<String, Error>) -> Void)
    
    func createPaymentIntent(postData: PaymentParameters, completion: @escaping (Result<String, Error>) -> Void)
    
}
