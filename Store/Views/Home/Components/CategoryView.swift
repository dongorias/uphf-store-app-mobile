//
//  Categorie.swift
//  Store
//
//  Created by Don Arias Agokoli on 17/01/2025.
//

import SwiftUI

struct CategoryView: View {
    @StateObject private var viewModel = CategoryViewModel()
    @State private var didAppear = false
    var body: some View {
        
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                VStack(alignment: .leading) {
                    Text("Catégories")
                        .font(.title2)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.categorys) { item in
                                CategoryItem(category: item)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
               
            }
        }
        .frame(height: 80) // Réduit la hauteur
        .alert("Erreur", isPresented: Binding(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )) {
            Text(viewModel.error?.localizedDescription ?? "")
        }
        .onAppear {
//            if !didAppear {
//                viewModel.fetchCategory()
//                didAppear = true
//            }
            
        }
    }
}

struct CategoryItem: View {
    var category: Category

    var body: some View {
        NavigationLink(destination: ProductByCategoryView(categoryId: category.id)){
            VStack(spacing: 8) { // Ajout d'un espacement contrôlé
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(hex: category.color))
                    .frame(width: 50, height: 50) // Dimensions fixes
                    .overlay(
                        Image(getCategoryImage(category.name))
                            .resizable()
                            .scaledToFit()
                            .padding(12)
                    )
                
                Text(category.name)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
     
    }
}

func getCategoryImage(_ categoryName: String) -> String {
    switch categoryName.lowercased() {
        case "apparel":
            return "apparel"
        case "school":
            return "school"
        case "sports":
            return "sport"
        case "electronic":
            return "electronic"
        case "all":
            return "all"
        default:
            return "questionmark.circle" // Image par défaut si la catégorie n'est pas reconnue
    }
}
