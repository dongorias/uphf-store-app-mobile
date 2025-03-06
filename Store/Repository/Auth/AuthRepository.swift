//
//  AuthRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import AuthenticationServices
import FirebaseAuth

protocol AuthRepository {
    func signInWithApple(authorization: ASAuthorization, nonce:String?, completion: @escaping (Result<User, Error>) -> Void)
    
    func saveCustomer(user: User, completion: @escaping (Result<Void, Error>) -> Void)
    
    func getCustomer(_ id:String) async throws -> Customer
    
    func logout() async throws
}
