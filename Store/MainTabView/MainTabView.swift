//
//  MainTabView.swift
//  market
//
//  Created by Don Arias Agokoli on 23/12/2024.
//
import SwiftUI

class TabMonitor: ObservableObject {
    @Published var selectedTab = 1
}


struct MainTabView: View {
    @StateObject private var tabMonitor = TabMonitor()
    @State private var selectedTab = "home"
    
    
    var body: some View {
        
        TabView(selection: $tabMonitor.selectedTab) {
            
            TabbedNavView(tag: 1) {
                
                    HomeView()
                
                
            }
            .tabItem {  Label("Accueil", image: "home") }
            .tag(1)
            
            
            
            TabbedNavView(tag: 2) {
                
                    SearchView()
                
                
            }
            .tabItem { Label("Rechercher", image: "search") }
            .tag(2)
            
            
            TabbedNavView(tag: 3) {
                
                    CartView()
                
            }
            .tabItem { Label("Panier", image: "cart") }
            .tag(4)
            
            
            
            TabbedNavView(tag: 4) {
                
                
                    ProfileView()
                
                
            }
            .tabItem { Label("Vous", image: "user") }
            .tag(3)
            
            
            
        } .accentColor(AppColors.primary)
            .environmentObject(tabMonitor)
        
        
        
        
        //        TabView (selection: $selectedTab) {
        //
        //            NavigationStack{
        //                HomeView()
        //            }
        //            .tabItem {
        //                Label("Accueil", image: "home")
        //            }
        //
        //            NavigationStack{
        //                SearchView()
        //            }
        //            .tabItem {
        //                Label("Rechercher", image: "search")
        //            }
        //            NavigationStack{
        //                CartView()
        //            }
        //            .tabItem {
        //                Label("Panier", image: "cart")
        //            }
        //
        //            NavigationStack{
        //                ProfileView()
        //            }
        //            .tabItem {
        //                Label("Vous", image: "user")
        //            }
        //        }
        //        .accentColor(AppColors.primary)
        
    }
}

struct TabbedNavView: View {
    @EnvironmentObject var tabMonitor: TabMonitor
    
    private var tag: Int
    private var content: AnyView
    
    init(
        tag: Int,
        @ViewBuilder _ content: () -> any View
    ) {
        self.tag = tag
        self.content = AnyView(content())
    }
    
    @State private var id = 1
    @State private var selected = false
    
    var body: some View {
        NavigationStack {
            content
                .id(id)
                .onReceive(tabMonitor.$selectedTab) { selection in
                    if selection != tag {
                        selected = false
                    } else {
                        if selected {
                            id *= -1 //id change causes pop to root
                        }
                        
                        selected = true
                    }
                } //.onReceive
        } //NavigationView
        .navigationViewStyle(.stack)
    } //body
} //TabbedNavView
