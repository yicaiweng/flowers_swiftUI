//
//  FlowersListViewModel.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import Foundation
import Observation

@Observable class FlowersListViewModel {
    private let apiKey = "a5e95177da353f58113fd60296e1d250"
    
    var flowers: [Flower] = []
    var totalFlower: Int = 0 // initialize to avoid uninitialized stored property error
    var page: Int = 1
    var hideMoreBtn: Bool = false
    
    init() {}
    
    func getFlowers() async {
          guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=1&per_page=21") else { return }
          do {
              let (data, resp) = try await URLSession.shared.data(from: url)
              let decoded = try JSONDecoder().decode(FlowerResp.self, from: data)
              await MainActor.run {
                  self.totalFlower = decoded.photos.total
                  self.flowers = decoded.photos.photo
              }
          } catch {
              print("Request failed:", error)
          }
      }
    
    func getFlowersByColour(color: Int) async {
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=1&per_page=21&color_codes=\(color)") else { return }
        do{
            let (data, resp) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(FlowerResp.self, from: data)
            await MainActor.run {
                self.totalFlower = decoded.photos.total
                self.flowers = decoded.photos.photo
            }
        } catch {
            print("Request failed: ", error)
        }
    }
    
    func getMoreFlower() async {
        page += 1
        guard let url = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=\(page)&per_page=21") else { return }
        do {
            let (data, resp) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(FlowerResp.self, from: data)
            await MainActor.run {
                self.totalFlower = decoded.photos.total
                self.flowers = decoded.photos.photo
            }
        } catch {
            print("Request failed: ", error)
        }
    }
}

