import SwiftUI

struct MenuRow: View {
    let title: String
    let icon: String
    var tint: Color = .swPrimary
    var trailingText: String? = nil
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: SWSpacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: SWRadius.sm, style: .continuous)
                        .fill(tint.opacity(0.14))
                        .frame(width: 36, height: 36)
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(tint)
                }
                Text(title)
                    .font(.swBody)
                    .foregroundStyle(Color.swTextPrimary)
                Spacer()
                if let trailingText {
                    Text(trailingText)
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                }
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(Color.swTextSecondary)
            }
            .padding(.vertical, SWSpacing.xs)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: SWSpacing.xs) {
        MenuRow(title: "My Orders", icon: "shippingbox.fill") {}
        MenuRow(title: "Favourites", icon: "heart.fill", tint: .swGrape) {}
        MenuRow(title: "Messages", icon: "bubble.left.and.bubble.right.fill", tint: .swSky, trailingText: "2 new") {}
        MenuRow(title: "Help Center", icon: "questionmark.circle.fill", tint: .swSecondary) {}
    }
    .padding()
    .background(Color.swBackground)
}
