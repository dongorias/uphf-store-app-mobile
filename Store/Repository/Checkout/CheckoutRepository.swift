//
//  CheckoutRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

protocol CheckoutRepository {
    func getOrders(_ userId: String) async throws -> [Order]
}
