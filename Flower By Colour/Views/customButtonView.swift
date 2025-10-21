//
//  customButtonView.swift
//  Flower By Colour
//
//  Created by Yicai Weng on 10/6/25.
//

import SwiftUI

struct CustomButtonView: View {
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
    let text: String = "Button"
    let color: Color = .green
    CustomButtonView(text: text, color: color)
}
