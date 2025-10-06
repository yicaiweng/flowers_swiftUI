//
//  FlowerImageView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct FlowerImageView: View {
    
    let flower: Flower
    
    var body: some View {
        AsyncImage(url: URL(string: "https://farm\(flower.farm).staticflickr.com/\(flower.server)/\(flower.id)_\(flower.secret).jpg)")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame( width: 100, height: 100)
    }
}

#Preview {
    FlowerImageView(flower: Flower(id: "54835340032", farm: 66, server: "65535", secret: "3b4604e002"))
}
