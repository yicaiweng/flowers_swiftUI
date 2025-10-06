//
//  customButtonView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct customButtonView: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.body)
            .bold()
            .padding(10)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    customButtonView(text: "button", color: .green)
}
