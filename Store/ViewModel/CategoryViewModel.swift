//
//  CategorieViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import Foundation

@MainActor
class CategoryViewModel : ObservableObject {
    @Published var categorys: [Category] = []
    @Published var isLoading = false
    @Published var error: Error?
    private let repository: CategoryRepository
    
    init(repository: CategoryRepository = FirestoreCategoryRepository()) {
        self.repository = repository
        fetchCategory()
    }
    
  
    
    func fetchCategory() {
        Task {
            isLoading = true
            do {
                self.categorys = try await repository.getCategorys()
                self.categorys.sort { $0.name == "All" ? false : $1.name == "All" ? true : $0.name < $1.name }
            } catch {
                self.error = error
            }
            isLoading = false
            
        }
        
    }
}
