//
//  OnboardingView.swift
//  market
//
//  Created by Don Arias Agokoli on 23/12/2024.
//
import SwiftUI

struct OnboardingPage: Identifiable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
}

struct OnboardingView: View {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var currentPage = 0
    
    private let pages: [OnboardingPage] = [
        OnboardingPage(image: "basket",
                       title: "Bienvenue sur notre boutique",
                       description: "Découvrez notre sélection de produits"),
        OnboardingPage(image: "discount",
                       title: "Promotions exclusives",
                       description: "Profitez de nos offres spéciales"),
        OnboardingPage(image: "payment",
                       title: "Paiement sécurisé",
                       description: "Payez en toute sécurité")
    ]
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(pages.indices, id: \.self) { index in
                VStack(spacing:20){
                    Image(pages[index].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 267)
                    Text(pages[index].title)
                        .fontWeight(.heavy)
                        .font(.system(size: 24))
                    Text(pages[index].description)
                        .fontWeight(.light)
                        .font(.system(size: 14))
                        .padding(.bottom,15)
                        .multilineTextAlignment(.center)
                    
                    if index == pages.count - 1 {  Button{
                        hasSeenOnboarding = true
                        
                    }label: {
                        HStack{
                            Text("Start")
                            Image(systemName: "arrow.forward.circle")
                        }
                        .padding(.horizontal,25)
                        .padding(.vertical,12)
                        .background(
                            Capsule().strokeBorder(lineWidth: 2)
                        )
                        .foregroundColor(AppColors.primary)
                        
                    }.buttonStyle(.plain)
                        
                    }}
                
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
