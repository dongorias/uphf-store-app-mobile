//
//  ContentView.swift
//  Store
//
//  Created by Don Arias Agokoli on 23/12/2024.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
       
       var body: some View {
           if !hasSeenOnboarding {
               OnboardingView()
           } else {
              
               MainTabView()
           }
       }
    init(){
//        for family in UIFont.familyNames {
//            print(family)
//            
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//                
//                
//            }
//        }
    }
}

#Preview {
    ContentView()
}
