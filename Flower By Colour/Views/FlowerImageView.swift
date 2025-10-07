//
//  FlowerImageView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct FlowerImageView: View {
    let flower: Flower
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: "https://farm\(flower.farm).staticflickr.com/\(flower.server)/\(flower.id)_\(flower.secret).jpg")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    FlowerImageView(
        flower: Flower(title: "flower",id: "54835340032", farm: 66, server: "65535", secret: "3b4604e002"),
        width: 200,
        height: 200
    )
}
