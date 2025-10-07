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
    
    func getFlowers() {
        if let apiURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=1&per_page=21") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(FlowerResp.self, from: data)
                        DispatchQueue.main.async {
                            self.totalFlower = decodedResponse.photos.total
                            self.flowers = decodedResponse.photos.photo
                            print(self.flowers)
                        }
                    } catch {
                        print("Decoding failed:", error)
                    }
                } else if let error = error {
                    print("Network error:", error)
                }
            }.resume()
        }
    }
    
    func getFlowersByColour(color: Int) {
        if let apiURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=1&per_page=21&color_codes=\(color)") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(FlowerResp.self, from: data)
                        DispatchQueue.main.async {
                            self.totalFlower = decodedResponse.photos.total
                            self.flowers = decodedResponse.photos.photo
                            print(self.flowers)
                        }
                    } catch {
                        print("Decoding failed:", error)
                    }
                } else if let error = error {
                    print("Network error:", error)
                }
            }.resume()
        }
    }
    
    func getMoreFlower() {
        page += 1
        if let apiURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=\(page)&per_page=21") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        let decodedResponse = try JSONDecoder().decode(FlowerResp.self, from: data)
                        DispatchQueue.main.async {
                            self.totalFlower = decodedResponse.photos.total
                            self.flowers += decodedResponse.photos.photo
                            print(self.flowers)
                        }
                    } catch {
                        print("Decoding failed:", error)
                    }
                } else if let error = error {
                    print("Network error:", error)
                }
            }.resume()
        }
    }
}

