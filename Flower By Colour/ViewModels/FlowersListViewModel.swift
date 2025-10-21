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
    private let apiURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key="
    
    var flowers: [Flower] = []
    var totalFlower: Int = 0 // initialize to avoid uninitialized stored property error
    var page: Int = 1
    var hideMoreBtn: Bool = false
    
    init() {}
    
    func fetchFlowers(color: Int? = nil, loadMore: Bool = false) async {
        if loadMore {
            page += 1
        } else {
            page = 1
        }

        var apiURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search"
        apiURL += "&text=flowers"
        apiURL += "&api_key=\(apiKey)"
        apiURL += "&format=json&nojsoncallback=1"
        apiURL += "&page=\(page)&per_page=21"
        
        if let color = color {
            apiURL += "&color_codes=\(color)"
        }
        print(apiURL)
        guard let url = URL(string: apiURL) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(FlowerResp.self, from: data)
            
            await MainActor.run {
                self.totalFlower = decoded.photos.total
                
                if loadMore {
                    self.flowers += decoded.photos.photo
                } else {
                    self.flowers = decoded.photos.photo
                }
                print(self.flowers)
            }
        } catch {
            print("Request failed:", error)
        }
    }
}

