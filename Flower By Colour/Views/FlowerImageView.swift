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
    let title: String = "Flower"
    let id: String = "54835340032"
    let farm: Int = 66
    let server: String = "65535"
    let secret: String = "3b4604e002"
    FlowerImageView(
        flower: Flower(title: title, id: id, farm: farm, server: server, secret: secret),
        width: 200,
        height: 200
    )
}
