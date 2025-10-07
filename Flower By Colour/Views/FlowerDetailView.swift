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
    FlowerDetailView(flowerDetail: Flower(title: "Flower",id: "54835340032", farm: 66, server: "65535", secret: "3b4604e002"))
}
