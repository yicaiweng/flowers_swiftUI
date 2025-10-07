//
//  Flower.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import Foundation

struct FlowerResp: Codable {
    var photos: Photos
}

struct Photos: Codable {
    var photo: [Flower]
    var total: Int
}

struct Flower: Identifiable, Codable {
    var title: String
    var id: String
    var farm: Int
    var server: String
    var secret: String
}

