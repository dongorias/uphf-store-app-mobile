//
//  BannerViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import SwiftUI

@MainActor
class BannerViewModel: ObservableObject {
    @Published var banners: [Banner] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private let repository: BannerRepository
    
    init(repository: BannerRepository = FirestoreBannerRepository()) {
        self.repository = repository
        fetchBanners()
    }
    
    func fetchBanners() {
        Task {
            isLoading = true
            do {
                banners = try await repository.getBanners()
            } catch {
                self.error = error
            }
            isLoading = false
        }
    }
}
