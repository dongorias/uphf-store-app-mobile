//
//  BannerRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

protocol CategoryRepository {
    func getCategorys() async throws -> [Category]
    //func addTodo(_ todo: Todo) async throws
    //func updateTodo(_ todo: Todo) async throws
    //func deleteTodo(_ id: String) async throws
}
