//
//  AuthViewModel.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import SwiftUICore
import FirebaseFirestore


@MainActor
class AuthViewModel: ObservableObject {
    
    enum AuthState{
        case signedIn
        case signedOut
    }
    
 
    @Published var isLoading = false
    @Published var customer:Customer?
    @Published var navigateToAuthView = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    private var authRepository: AuthRepository
    
    var authState: AuthState = .signedOut
    var user: User? = nil
    private var authStateListener: AuthStateDidChangeListenerHandle?
    
    
    private let db = Firestore.firestore()
    private let collection = "users"
    
    init(repository: AuthRepository = FirebaseAuthRepository()) {
        self.authRepository = repository
        configureAuthStateListener()
        checkAuthState()
        //self.isLoggedIn = authRepository.isUserLoggedIn()
    }
    
    
    private func configureAuthStateListener() {
        authStateListener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            
            if let user = user {
                self.authState = .signedIn
                fetchCustomer(user.uid)
            } else {
                self.authState = .signedOut
            }
            
            print("Auth State changed: \(self.authState)")
        }
    }
    
    func checkAuthState() {
        if let currentUser = Auth.auth().currentUser {
            self.user = currentUser
            fetchCustomer(currentUser.uid)
            self.authState = .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    
    func signInWithApple(_ authorization: ASAuthorization, _ nonce: String?) {
        isLoading = true
        Task {
            
            // Authentification avec Apple
            authRepository.signInWithApple(authorization: authorization, nonce: nonce){ result in
                switch result {
                case .success(let user):
                    self.authRepository.saveCustomer(user: user){ response in
                        switch response {
                        case .success:
                            
                            self.configureAuthStateListener()
                            
                        case .failure(let error):
                            self.navigateToAuthView = false
                            self.isLoading = false
                            self.showAlert = true
                            self.alertMessage = error.localizedDescription
                        }
                        
                    }
                    break
                case .failure(_):
                    break
                }
            }
            
        }
        
    }
    
    func fetchCustomer(_ userId:String) {
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let details = try await self.authRepository.getCustomer(userId)
                await MainActor.run {
                    self.customer = details
                    self.isLoading = false
                    self.navigateToAuthView = false
                }
            } catch {
                print("Failed to fetch user details: \(error)")
                await MainActor.run {
                    self.alertMessage = "Failed to fetch user details"
                }
            }
        }
        
        
        
        //        // Mettre isLoading à true avant de commencer la tâche
        //        self.isLoading = true
        //
        //        Task {
        //            do {
        //                // Vérifiez si l'utilisateur est connecté
        //                guard let currentUser = Auth.auth().currentUser else {
        //                    throw NSError(domain: "AuthError", code: 1, userInfo: [NSLocalizedDescriptionKey: "User not logged in"])
        //                }
        //
        //                // Récupérer le client
        //                self.customer = try await self.authRepository.getCustomer(currentUser.uid)
        //                self.isLoading = false
        //                self.navigateToAuthView = false
        //                self.isLoggedIn = true
        //            } catch {
        //                // Gérer les erreurs
        //                DispatchQueue.main.async {
        //                    self.showAlert = true
        //                    self.alertMessage = error.localizedDescription
        //                    self.isLoading = false // Assurez-vous de mettre isLoading à false en cas d'erreur
        //                }
        //            }
        //        }
    }
    
    
    func logout() {
        Task {
            do {
                try await authRepository.logout()
                self.isLoading = false
                // Mettre à jour l'état de l'authentification
            } catch {
                // Gérer l'erreur
                print("Failed to sign in with Apple: \(error)")
            }
        }
    }
    
    
//    func isUserLoggedIn() {
//        self.isLoggedIn = Auth.auth().currentUser != nil
//    }
    
    
}



