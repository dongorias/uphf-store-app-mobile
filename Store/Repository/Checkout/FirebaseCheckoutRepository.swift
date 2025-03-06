//
//  FirebaseCheckoutRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 16/02/2025.
//

import FirebaseFirestore

class FirestoreCheckoutRepository: CheckoutRepository {
    private let db = Firestore.firestore()
    private let collection = "orders"
    
    func getOrders(_ userId: String) async throws -> [Order] {
       
        let snapshot = try await db.collection(collection).whereField("userId", isEqualTo: userId).getDocuments()
        return try snapshot.documents.map { document in
            let orders = try document.data(as: Order.self)
            
            return orders
        }
    }

}
