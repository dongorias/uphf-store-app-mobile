//
//  OrderView.swift
//  Store
//
//  Created by Don Arias Agokoli on 21/02/2025.
//

import SwiftUI

struct OrderView : View {
    @StateObject private var checkoutViewModel = CheckoutViewModel()
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        
        VStack{
            
            if checkoutViewModel.orders.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "basket")
                        .font(.system(size: 50))
                        .foregroundColor(.gray.opacity(0.7))
                    
                    Text("Aucune commande")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Text("Vous n'avez pas encore effectué de commande")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal, 32)
                }
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity)
            } else {
                List {
                    ForEach(checkoutViewModel.orders) { item in
                        VStack(spacing: 12) {
                            HStack {
                                Text("Commande #\(item.id ?? "")")
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("\(item.createdAt, formatter: dateFormatter)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            HStack {
                                Text(item.statut)
                                    .font(.subheadline)
                                    .foregroundColor(statusColor(for: item.statut))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(statusColor(for: item.statut).opacity(0.1))
                                    .cornerRadius(6)
                                
                                Spacer()
                            }
                            
                            Divider()
                            
                            HStack {
                                Text("Total")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Text("\(String(format: "%.2f", item.total)) €")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                        .padding(.vertical, 4)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                }
                .listStyle(PlainListStyle())
            }
        }
        .onAppear{
            self.checkoutViewModel.setup(self.authViewModel)
            checkoutViewModel.fetchOrders()
            
            
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
}

func statusColor(for status: String) -> Color {
    switch status.lowercased() {
    case "en cours":
        return .blue
    case "expédiée":
        return .orange
    case "livrée":
        return .green
    case "annulée":
        return .red
    case "en attente":
        return .yellow
    default:
        return .gray
    }
}
