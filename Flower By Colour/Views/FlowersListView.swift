//
//  ContentView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct FlowersListView: View {
    private var flowersListViewModel = FlowersListViewModel()
    @State private var currentTitle: String = "All Flowers"
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            if flowersListViewModel.flowers.count == 0 {
                VStack {
                    ProgressView()
                    Text("Fetching Flower Data...")
                }
                .onAppear {
                    flowersListViewModel.getFlowers()
                    currentTitle = " All Flowers"
                }
            } else {
                VStack {
                    HStack() {
                        Text("Total Flowers: \(flowersListViewModel.totalFlower)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Button( action: {
                            flowersListViewModel.hideMoreBtn = false
                            flowersListViewModel.getFlowers()
                            currentTitle = "All Flowers"
                        }){
                            customButtonView(text: "All", color: .orange)
                        }
                        
                        Button( action: {
                            flowersListViewModel.hideMoreBtn = true
                            flowersListViewModel.getFlowersByColour(color: 0)
                            currentTitle = "Red Flowers"
                        }){
                            customButtonView(text: "Red", color: .red)
                        }
                        Button( action: {
                            flowersListViewModel.hideMoreBtn = true
                            flowersListViewModel.getFlowersByColour(color: 5)
                            currentTitle = "Green Flowers"
                        }){
                            customButtonView(text: "Green", color: .green)
                        }
                        Button( action: {
                            flowersListViewModel.hideMoreBtn = true
                            flowersListViewModel.getFlowersByColour(color: 8)
                            currentTitle = "Blue Flowers"
                        }){
                            customButtonView(text: "Blue", color: .blue)
                        }
                    }
                    .padding()
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(flowersListViewModel.flowers) { flower in
                                NavigationLink(destination: FlowerDetailView(flowerDetail: flower)) {
                                    FlowerImageView(flower: flower, width: 100, height: 100)
                                        .scaledToFill()
                                }
                            }
                        }
                        if !flowersListViewModel.hideMoreBtn {
                            Button(action: {
                                flowersListViewModel.getMoreFlower()
                            }){
                                customButtonView(text: "More Flower", color: .purple)
                                    .padding()
                            }
                        }
                    }
                    .navigationTitle(currentTitle)
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
}

#Preview {
    FlowersListView()
}
