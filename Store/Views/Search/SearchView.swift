//
//  SearchView.swift
//  Store
//
//  Created by Don Arias Agokoli on 07/02/2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = ProductViewModel()
    
    
    var body: some View {
       
        VStack {
            SearchBar(text: $viewModel.searchQuery, onSearch: {
                viewModel.searchProducts()
            }).padding(.horizontal)
            
            ZStack {
                if viewModel.listProductSearch.isEmpty {
                    VStack {
                        Spacer()
                        
                        Text(viewModel.lastSearchQuery.isEmpty ? "Recherchez un produit" : "Aucun résultat pour \(viewModel.lastSearchQuery)")
                            .font(.title3)
                            .foregroundColor(.gray)
                            .bold()
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(viewModel.listProductSearch) { item in
                            NavigationLink(destination: ProductDetailView(product: item)){
                                HStack(spacing: 12) {
                                    AsyncImage(url: URL(string: item.url)) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(RoundedRectangle(cornerRadius: 8))
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 80, height: 80)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(item.name)
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                            .lineLimit(2)
                                        
                                        Text("\(item.price, specifier: "%.2f") €")
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                    }
                                    .padding(.vertical, 8)
                                }
                                .padding(.vertical, 4)
                            }
                           
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            
        }
        .onAppear{
            viewModel.searchProducts()
        }
        .navigationTitle("Recherche")
    }
    
}
