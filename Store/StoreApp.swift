//
//  StoreApp.swift
//  Store
//
//  Created by Don Arias Agokoli on 23/12/2024.
//

import SwiftUI
import FirebaseCore
import StripeApplePay

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        StripeAPI.defaultPublishableKey = "pk_test_oKhSR5nslBRnBZpjO6KuzZeX"
        
        return true
    }
}

@main
struct StoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var authViewModel: AuthViewModel
    
    
    init(){
        FirebaseApp.configure()
        self.authViewModel = AuthViewModel()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
            // Injection de l'AuthViewModel dans l'environnement
        }
    }
}
