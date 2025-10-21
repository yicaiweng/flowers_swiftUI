//
//  FlowerDetailView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/7/25.
//

import SwiftUI

struct FlowerDetailView: View {
    let flowerDetail: Flower
    
    var body: some View {
        NavigationStack {
            HStack {
                    FlowerImageView(flower: flowerDetail, width: 250, height: 200)
            }.navigationTitle("Flower Detail")
            VStack(alignment: .leading) {
                Text("Title: \(flowerDetail.title)")
                    .bold()
            }
            .padding()
                Spacer()
        }
    }
}

#Preview {
    let title: String = "Flower"
    let id: String = "54835340032"
    let farm: Int = 66
    let server: String = "65535"
    let secret: String = "3b4604e002"
    FlowerDetailView(flowerDetail: Flower(title: title, id: id, farm: farm, server: server, secret: secret))
}
