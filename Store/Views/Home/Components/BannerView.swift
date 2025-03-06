//
//  BannerView.swift
//  market
//
//  Created by Don Arias Agokoli on 23/12/2024.
//
import SwiftUI


struct BannerView: View {
    @StateObject private var viewModel = BannerViewModel()
    let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    @State private var currentIndex = 0
    @State private var didAppear = false
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                TabView(selection: $currentIndex) {
                    ForEach(viewModel.banners) { item in
                        BannerRow(banner: item)
                    }
                }
                .frame(height: 180)
                .tabViewStyle(PageTabViewStyle())
                .onReceive(timer) { _ in
                    withAnimation {
                        currentIndex = (currentIndex + 1) % viewModel.banners.count
                    }
                }
            }
        }
        .onAppear {
//            if !didAppear {
//                viewModel.fetchBanners()
//                didAppear = true
//            }
            
        }
    }
}

struct BannerRow: View {
    let banner: Banner
    
    var body: some View {
        ZStack {
                        Color(.systemYellow)
                            .opacity(0.2)
                        HStack {
                            VStack(alignment: .leading) {
                                Text("SALE")
                                    .foregroundColor(.orange)
                                Text("UPTO\n60% OFF")
                                    .font(.title)
                                    .bold()
                                Text("School Collections")
                            }
                            Spacer()
                            Image("image")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                        }
                        .padding()
                    }
                    .cornerRadius(15)
    }
}
