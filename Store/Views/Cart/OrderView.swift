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
            List {
                ForEach(checkoutViewModel.orders) { item in
                    VStack(alignment: .leading) {
                        HStack{
                            Text("#\(item.id!)")
                            Spacer()
                            Text("\(item.createdAt, formatter: dateFormatter)")
                        }
                        Text("\(item.statut)")
                    }
                    HStack{
                        Text("Total")
                        Spacer()
                        Text("\(String(format: "%.2f", item.total)) €")
                    }
                    
                }
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
