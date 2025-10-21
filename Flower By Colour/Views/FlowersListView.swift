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
                    Task {
                        await flowersListViewModel.fetchFlowers()
                    }
                    currentTitle = "All Flowers"
                }
            } else {
                VStack {
                    HStack() {
                        Text("Total Flowers: \(flowersListViewModel.totalFlower)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        FilterButton(title: "All", color: .orange) {
                            flowersListViewModel.hideMoreBtn = false
                            await flowersListViewModel.fetchFlowers()
                            currentTitle = "All Flowers"
                        }
                        FilterButton(title: "Red", color: .red) {
                            flowersListViewModel.hideMoreBtn = true
                            await flowersListViewModel.fetchFlowers(color: 0)
                            currentTitle = "Red Flowers"
                        }
                        FilterButton(title: "Green", color: .green) {
                            flowersListViewModel.hideMoreBtn = true
                            await flowersListViewModel.fetchFlowers(color: 5)
                            currentTitle = "Green Flowers"
                        }
                        FilterButton(title: "Blue", color: .blue) {
                            flowersListViewModel.hideMoreBtn = true
                            await flowersListViewModel.fetchFlowers(color: 8)
                            currentTitle = "Blue Flowers"
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
                                Task {
                                    await flowersListViewModel.fetchFlowers(loadMore: true)
                                }
                            }){
                                CustomButtonView(text: "More Flower", color: .purple)
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

