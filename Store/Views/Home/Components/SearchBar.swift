//
//  SearchBar.swift
//  Store
//
//  Created by Don Arias Agokoli on 31/01/2025.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Rechercher un produit", text: $text, onCommit:{
                onSearch()
            })
            .multilineTextAlignment(.leading)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
