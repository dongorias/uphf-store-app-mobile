//
//  DeliveryAddressView.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import SwiftUI

struct DeliveryAddressView: View {
    @StateObject private var locationViewModel = LocationViewModel()
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Adresse de livraison")
                    .foregroundColor(.gray)
                Text(locationViewModel.locationName).font(.headline)
            }
            Spacer()
            
            // Badge(count: 2)
            Image(systemName: "bell")
                .font(.title2)
        }.onAppear {
            locationViewModel.getUserLocation()
        }
        .padding()
    }
}
