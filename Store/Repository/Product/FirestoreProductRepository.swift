//
//  FirestoreBannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import FirebaseFirestore

class FirestoreProductRepository: ProductRepository {
    private let db = Firestore.firestore()
    private let collection = "products"
    
    func getRecentProduct() async throws -> [Product] {
        let snapshot = try await db.collection(collection)
            .order(by: "createdAt", descending: true) // Tri par date décroissante
                        .limit(to: 10).getDocuments()
        return try snapshot.documents.map { document in
            let product = try document.data(as: Product.self)
            return product
        }
    }
    
    func getProductByCategory(_ categoryId:String) async throws -> [Product] {
        let snapshot = try await db.collection(collection).whereField("category", isEqualTo: categoryId).getDocuments()
        return try snapshot.documents.map { document in
            let product = try document.data(as: Product.self)
            return product
        }
    }
    func getAllProduct() async throws -> [Product] {
        let snapshot = try await db.collection(collection).getDocuments()
        return try snapshot.documents.map { document in
            let product = try document.data(as: Product.self)
            return product
        }
    }
    
    func searchProducts(by name: String, completion: @escaping ([Product]) -> Void) {
        db.collection(collection)
            .whereField("name", isGreaterThanOrEqualTo: name)
                .whereField("name", isLessThanOrEqualTo: name + "\u{f8ff}") // Pour une recherche par préfixe
                .getDocuments { (snapshot, error) in
                    var products: [Product] = []
                    
                    if let error = error {
                        print("Error fetching products: \(error)")
                        completion(products)
                        return
                    }
                    
                    for document in snapshot?.documents ?? [] {
                        if let product = try? document.data(as: Product.self) {
                            products.append(product)
                        }
                    }
                    completion(products)
                }
        }
    
}
