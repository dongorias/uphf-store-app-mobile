//
//  BannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

protocol BannerRepository {
    func getBanners() async throws -> [Banner]
}
