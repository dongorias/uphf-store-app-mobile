//
//  ProfileView.swift
//  market

//
import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isOderInfo = false
    
    var body: some View {
        
        VStack {
            
            switch authViewModel.authState {
            case .signedIn:
                
                Form {
                    
                    NavigationLink(destination: OrderView()){
                        HStack{
                            Text("Mes commandes")
                        }.onTapGesture {
                            self.isOderInfo = true
                        }
                    }
                    
                }
                
                Spacer()
                
                Button(action: {
                    
                    authViewModel.logout()
                    
                }) {
                    Text("Déconnexion")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                }
                .padding()
                
                
            case.signedOut:
                Spacer()
                
                Button(action: {
                    authViewModel.navigateToAuthView = true
                    
                }) {
                    
                    Text("Connecter vous pour accéder au profil")
                        .foregroundColor(.red)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    
                    
                }
                .padding()
            }
            
        }
        .sheet(isPresented: $authViewModel.navigateToAuthView, content: {
            AuthView().presentationDetents([.fraction(0.15)])
        })
        .onAppear {
            
            
        }.navigationTitle("Mon Profil")
        
    }
    
}


