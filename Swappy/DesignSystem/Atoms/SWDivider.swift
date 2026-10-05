import SwiftUI

struct SWDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.swBorder)
            .frame(height: 1)
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        Text("Above")
        SWDivider()
        Text("Below")
    }
    .padding()
    .background(Color.swBackground)
}
