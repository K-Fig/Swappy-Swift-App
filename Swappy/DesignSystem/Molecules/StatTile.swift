import SwiftUI

struct StatTile: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.swTitle)
                .foregroundStyle(Color.swTextPrimary)
            Text(label)
                .font(.swCaption)
                .foregroundStyle(Color.swTextSecondary)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    HStack {
        StatTile(value: "128", label: "Listings")
        StatTile(value: "4.8", label: "Rating")
        StatTile(value: "2y", label: "Member")
    }
    .padding()
    .background(Color.swBackground)
}
