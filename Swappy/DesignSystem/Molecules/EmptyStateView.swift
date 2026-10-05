import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: SWSpacing.md) {
            ZStack {
                Circle()
                    .fill(Color.swSurfaceAlt)
                    .frame(width: 88, height: 88)
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundStyle(Color.swTextSecondary)
            }
            VStack(spacing: SWSpacing.xxs) {
                Text(title)
                    .font(.swHeadline)
                    .foregroundStyle(Color.swTextPrimary)
                Text(message)
                    .font(.swBody)
                    .foregroundStyle(Color.swTextSecondary)
                    .multilineTextAlignment(.center)
            }
            if let actionTitle, let action {
                SWButton(title: actionTitle, style: .primary, isFullWidth: false, action: action)
            }
        }
        .padding(SWSpacing.xl)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    EmptyStateView(icon: "cart", title: "Your cart is empty", message: "Browse Swappy and add something you love.", actionTitle: "Start shopping") {}
        .background(Color.swBackground)
}
