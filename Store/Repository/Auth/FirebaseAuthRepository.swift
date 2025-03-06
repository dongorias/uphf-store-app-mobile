//
//  FirebaseAuthRepository.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import FirebaseAuth
import AuthenticationServices
import Foundation
import CryptoKit
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import SwiftUICore

class FirebaseAuthRepository: AuthRepository {
   
    private let stripeRepository: StripeRepository
    private let db = Firestore.firestore()
    private let collection = "users"
    
    var user: User?
    private var authenticationStateHandle: AuthStateDidChangeListenerHandle?
    
    init(repository: StripeRepository = StripeRepositoryImpl()) {
        self.stripeRepository = repository
        
    }
    
  

    
    func getProductByCategory(_ categoryId:String) async throws -> [Product] {
        let snapshot = try await db.collection(collection).whereField("category", isEqualTo: categoryId).getDocuments()
        return try snapshot.documents.map { document in
            let product = try document.data(as: Product.self)
            return product
        }
    }
    
    func getCustomer(_ id: String) async throws -> Customer {
        let documentSnapshot = try await db.collection(self.collection).document(id).getDocument()
        
        // Vérifiez si le document existe
        guard documentSnapshot.exists else {
            throw NSError(domain: "FirestoreError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Customer not found"])
        }
        
        // Tentez de décoder le document en un objet Customer
        let customer = try documentSnapshot.data(as: Customer.self)
        print(".FirebaseAuthRepository.swift: getCustomer(): \(String(describing: customer))")
        return customer
    }
    
    func saveCustomer(user: User, completion: @escaping (Result<Void, any Error>) -> Void) {
        
        
        db.collection(self.collection).document(user.uid).getDocument { document, error in
            if let error = error as NSError? {
                completion(.failure(error))
            }
            else {
                if document?.data() != nil {
                //let id = document.documentID
                  do {
                      //let id = document.documentID
                      //let data = document.data()
                      print("doc exist to get user==>\(String(describing: document))")
                     // print("doc id =>\(id)")
                     // print("doc data =>\(String(describing: data))")
                      self.db.collection(self.collection).document(user.uid).updateData(
                          [
                              "name": user.displayName ?? "",
                              "email": user.email ?? ""
                          ]) { error in
                              if let error = error {
                                  completion(.failure(error))
                              } else {
                                  completion(.success(()))
                              }
                          }
                  }
                  
              }else{
                  self.stripeRepository.createCustomerPaymentId { result in
                      switch result {
                      case .success(let id):
                          // Ajouter l'utilisateur à Firestore
                          self.db.collection(self.collection).document(user.uid).setData(
                              [
                                  "id": user.uid,
                                  "paymentId": id,
                                  "name": user.displayName ?? "",
                                  "email": user.email ?? "",
                              ]) { error in
                                  if let error = error {
                                      completion(.failure(error))
                                  } else {
                                      completion(.success(()))
                                  }
                              }
                      case .failure( let error):
                          completion(.failure(error))
                          
                          
                      }
                      
                  }
              }
            }
          }
        
        
//        db.collection(self.collection).document(user.uid).getDocument { document, error in
//        
//            if (error as NSError?) != nil {
//                print("error get user==>\(String(describing: error))")
//            
//            }
//            else {
//                print("try to get user==>\(String(describing: document))")
//                if document != nil {
//                    do {
//                        print("doc exist to get user==>\(String(describing: document))")
//                        self.db.collection(self.collection).document(user.uid).updateData(
//                            [
//                                "name": user.displayName ?? "",
//                                "email": user.email ?? ""
//                            ]) { error in
//                                if let error = error {
//                                    completion(.failure(error))
//                                } else {
//                                    completion(.success(()))
//                                }
//                            }
//                    }
//                
//                }else {
//                    self.stripeRepository.createCustomerPaymentId { result in
//                        switch result {
//                        case .success(let id):
//                            // Ajouter l'utilisateur à Firestore
//                            self.db.collection(self.collection).document(user.uid).setData(
//                                [
//                                    "id": user.uid,
//                                    "paymentId": id,
//                                    "name": user.displayName ?? "",
//                                    "email": user.email ?? "",
//                                ]) { error in
//                                    if let error = error {
//                                        completion(.failure(error))
//                                    } else {
//                                        completion(.success(()))
//                                    }
//                                }
//                        case .failure( let error):
//                            completion(.failure(error))
//                            
//                            
//                        }
//                        
//                    }
//                }
//            }
//        }
        
    }
    
    
    func signInWithApple(authorization: ASAuthorization, nonce:String?, completion: @escaping (Result<User, any Error>) -> Void) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce  else {
                completion(.failure(NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid nonce"])))
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                completion(.failure(NSError(domain: "AuthError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to fetch identity token"])))
                return
                
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                completion(.failure(NSError(domain: "AuthError", code: 3, userInfo: [NSLocalizedDescriptionKey: "Unable to serialize token string from data"])))
                return
                
            }
            // Initialize a Firebase credential, including the user's full name.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                           rawNonce: nonce,
                                                           fullName: appleIDCredential.fullName)
            
            // Sign in with Firebase.
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if (error != nil) {
                    // Error. If error.code == .MissingOrInvalidNonce, make sure
                    // you're sending the SHA256-hashed nonce as a hex string with
                    // your request to Apple.
                    
                    completion(.failure(NSError(domain: "AuthError", code: 4, userInfo: [NSLocalizedDescriptionKey:error?.localizedDescription as Any])))
                    
                    
                    return
                }
                // User is signed in to Firebase with Apple.
                if let user = authResult?.user {
                    completion(.success(user))
                } else {
                    completion(.failure(NSError(domain: "AuthError", code: 5, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                }
                //                // User is signed in to Firebase with Apple.
                //                completion(.success((authResult!.user)))
            }
            
        }
        completion(.failure(NSError(domain: "AuthError", code: 5, userInfo: [NSLocalizedDescriptionKey:"Authorization failed"])))
        
    }
    
    func logout() async throws {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
