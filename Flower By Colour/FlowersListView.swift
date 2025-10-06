//
//  ContentView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct FlowersListView: View {
    private let apiKey = "a5e95177da353f58113fd60296e1d250"
    
    @State var flowers: [Flower] = []
    @State var totalFlower: Int
    @State var page: Int = 1
    @State var hideMoreBtn: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            if flowers.count == 0 {
                VStack {
                    ProgressView()
                    Text("Fetching Flower Data...")
                }
                .onAppear { getFlowers()}
            } else {
                VStack {
                    HStack() {
                        Text("Total Flowers: \(totalFlower)")
                            .padding()
                        Spacer()
                    }
                    HStack {
                        Button( action: {
                            hideMoreBtn = false
                            getFlowers()
                        }){
                            customButtonView(text: "All", color: .orange)
                        }
                        
                        Button( action: {
                            hideMoreBtn = true
                            getFlowersByColour(color: 0)
                        }){
                            customButtonView(text: "Red", color: .red)
                        }
                        Button( action: {
                            hideMoreBtn = true
                            getFlowersByColour(color: 5)
                        }){
                            customButtonView(text: "Green", color: .green)
                        }
                        Button( action: {
                            hideMoreBtn = true
                            getFlowersByColour(color: 8)
                        }){
                            customButtonView(text: "Blue", color: .blue)
                        }
                    }
                    .padding()
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(flowers) { flower in
                                FlowerImageView(flower: flower)
                                    .scaledToFill()
                            }
                        }
                        if !hideMoreBtn {
                            Button(action: {
                                getMoreFlower()
                            }){
                                customButtonView(text: "More Flower", color: .purple)
                                    .padding()
                            }
                        }
                    }
                    .navigationTitle("Flowers")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
    }
    
    func getFlowers() {
        if let apiURL = URL(string: "https://api.flickr.com/services/rest/?method=flickr.photos.search&text=flowers&api_key=\(apiKey)&format=json&nojsoncallback=1&page=1&per_page=21") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                   if let data = data {
                       do {
                           let decodedResponse = try JSONDecoder().decode(FlowerResp.self, from: data)
                           DispatchQueue.main.async {
                               totalFlower = decodedResponse.photos.total
                               self.flowers = decodedResponse.photos.photo
                               print(self.flowers) // ✅ This should print now
                           }
                       } catch {
                           print("❌ Decoding failed:", error)
                       }
                   } else if let error = error {
                       print("❌ Network error:", error)
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
                               totalFlower = decodedResponse.photos.total
                               self.flowers = decodedResponse.photos.photo
                               print(self.flowers) // ✅ This should print now
                           }
                       } catch {
                           print("❌ Decoding failed:", error)
                       }
                   } else if let error = error {
                       print("❌ Network error:", error)
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
                               totalFlower = decodedResponse.photos.total
                               self.flowers = decodedResponse.photos.photo
                               print(self.flowers) // ✅ This should print now
                           }
                       } catch {
                           print("❌ Decoding failed:", error)
                       }
                   } else if let error = error {
                       print("❌ Network error:", error)
                   }
               }.resume()
        }
    }
}

#Preview {
    FlowersListView(totalFlower: 0)
}
