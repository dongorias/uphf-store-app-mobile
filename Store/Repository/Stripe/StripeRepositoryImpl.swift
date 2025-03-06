//
//  ImplStripRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

import Alamofire
import Foundation

class StripeRepositoryImpl: StripeRepository {
    
    private let apiKey = "sk_test_VePHdqKTYQjKNInc7u56JBrQ"
    private let baseURL = "https://api.stripe.com/v1/"
    
    
    func createCustomerPaymentId(completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://api.stripe.com/v1/customers"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)"
        ]
        
        AF.request(url, method: .post, headers: headers
        ).responseDecodable(of:StripUser.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value.id))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createPaymentIntent(postData: PaymentParameters, completion: @escaping (Result<String, Error>) -> Void) {
        let url = "https://api.stripe.com/v1/payment_intents"
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        let parameters: [String: Any] = [
              "customer": "cus_RmhvSo8BYmD2Yr",
              "amount": 5 * 100,
              "currency": "eur"
          ]
        
        
        AF.request(url, method: .post,
                   parameters: postData.dictionary,
                   encoding: URLEncoding.default,
                   headers: headers).responseDecodable(of: PaymentIntent.self) { response in
            debugPrint("response==>\(response)")
            switch response.result {
            case .success(let value):
                debugPrint("value==>\(value)")
                completion(.success(value.clientSecret))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

