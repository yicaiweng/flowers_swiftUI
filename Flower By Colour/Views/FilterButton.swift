import SwiftUI

struct FilterButton: View {
    let title: String
    let color: Color
    let action: () async -> Void

    var body: some View {
        Button(action: {
            Task { await action() }
        }) {
            CustomButtonView(text: title, color: color)
        }
    }
}

#Preview {
    let title: String = "all"
    let color: Color = .orange
    FilterButton(title: title, color: color) {}
}
