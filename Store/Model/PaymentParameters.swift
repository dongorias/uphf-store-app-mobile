//
//  PaiementParam.swift
//  Store
//
//  Created by Don Arias Agokoli on 21/02/2025.
//

struct PaymentParameters {
    let customer: String
    let amount: Double
    let currency: String = "eur"
    
    var dictionary: [String: Any] {
        return [
            "customer": customer,
            "amount": amount,
            "currency": currency
        ]
    }
}
