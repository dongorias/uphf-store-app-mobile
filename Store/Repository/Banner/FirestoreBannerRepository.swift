//
//  FirestoreBannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import FirebaseFirestore

class FirestoreBannerRepository: BannerRepository {
    private let db = Firestore.firestore()
    private let collection = "banners"
    
    func getBanners() async throws -> [Banner] {
        let snapshot = try await db.collection(collection).getDocuments()
        return try snapshot.documents.map { document in
            let banner = try document.data(as: Banner.self)
            //banner.id = document.documentID
            return banner
        }
    }
}
