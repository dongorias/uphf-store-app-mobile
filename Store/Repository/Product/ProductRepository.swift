//
//  BannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

protocol ProductRepository {
    func getRecentProduct() async throws -> [Product]
    func getProductByCategory(_ id: String) async throws -> [Product]
    func getAllProduct() async throws -> [Product]
    func searchProducts(by name: String, completion: @escaping ([Product]) -> Void)
}
