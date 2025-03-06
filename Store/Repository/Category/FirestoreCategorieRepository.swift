//
//  FirestoreBannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import FirebaseFirestore

class FirestoreCategoryRepository: CategoryRepository {
    private let db = Firestore.firestore()
    private let collection = "categorys"
    
    func getCategorys() async throws -> [Category] {
        let snapshot = try await db.collection(collection).getDocuments()
        return try snapshot.documents.map { document in
            let category = try document.data(as: Category.self)
            return category
        }
    }
    
//    func addTodo(_ todo: Todo) async throws {
//        var todoDict = try todo.dictionary()
//        todoDict.removeValue(forKey: "id")
//        try await db.collection(collection).document().setData(todoDict)
//    }
//    
//    func updateTodo(_ todo: Todo) async throws {
//        var todoDict = try todo.dictionary()
//        todoDict.removeValue(forKey: "id")
//        try await db.collection(collection).document(todo.id).setData(todoDict)
//    }
//    
//    func deleteTodo(_ id: String) async throws {
//        try await db.collection(collection).document(id).delete()
//    }
}
