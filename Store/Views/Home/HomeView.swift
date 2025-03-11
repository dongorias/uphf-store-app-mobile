//
//  Home.swift
//  market
//
//  Created by Don Arias Agokoli on 23/12/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            DeliveryAddressView()
    
            NavigationLink(destination: SearchView()) {
                SearchBar(text: .constant(""), onSearch: {})
            }
            .padding(.horizontal)
            ScrollView {
                BannerView().padding()
                CategoryView().padding(.vertical)
                ProductView().padding(.vertical)
            }
        }
        
        .onAppear {

        }
        
    }
}
