//
//  BannerViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import SwiftUI

@MainActor
class ProductViewModel : ObservableObject {
    @Published var recentProduct: [Product] = []
    @Published var productByCategory: [Product] = []
    @Published var listProductSearch: [Product] = []
    @Published var isLoading = false
    @Published var error: Error?
    @Published var searchQuery: String = ""
    @Published var lastSearchQuery: String = ""
    @Published var searchMessage :String = ""
    
    private let repository: ProductRepository
    
    init(repository: ProductRepository = FirestoreProductRepository()) {
        self.repository = repository
        fetchProduct()
    }
    
    func fetchProduct() {
        Task {
            isLoading = true
            do {
                recentProduct = try await repository.getRecentProduct()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    func fetchProductByCategory(_ id:String) {
        Task {
            isLoading = true
            do {
                if(id.isEmpty){
                    productByCategory = try await repository.getAllProduct()
                }else{
                    productByCategory = try await repository.getProductByCategory(id)
                }
                
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
    
    
    func searchProducts() {
        Task{
            isLoading = true
            // Trim les espaces avant de lancer la recherche
            searchQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
            lastSearchQuery = searchQuery
            repository.searchProducts(by: searchQuery) { [weak self] products in
                DispatchQueue.main.async {
                    if(products.isEmpty){
                        self?.searchMessage = "Aucun article trouver pour "
                    }
                    self?.listProductSearch = products
                }
            }
            isLoading = false
        }
    }
}
