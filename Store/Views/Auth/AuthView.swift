//
//  AuthView.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import SwiftUI
import _AuthenticationServices_SwiftUI
import CryptoKit
import AuthenticationServices
import FirebaseAuth

struct AuthView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var nonce: String?
    var body: some View {
        VStack {
            
            Spacer()
            if authViewModel.isLoading {
                ProgressView()
            } else {
                SignInWithAppleButton{ request in
                    let nonce = AuthUtils.randomNonceString()
                    self.nonce = nonce
                    request.requestedScopes = [.email, .fullName]
                    request.nonce = AuthUtils.sha256(nonce)
                } onCompletion:{ result in
                    switch result {
                    case .success(let authorization):
                        authViewModel.signInWithApple(authorization, nonce)
                    case .failure(_):
                        print("error")
                        
                    }
                }.frame(height: 45)
                    .clipShape(.capsule).padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
                
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .padding()
    }
}


