import SwiftUI

struct ErrorStateView: View {
    var title: String = "Something went wrong"
    var message: String = "Check your connection and try again."
    var retryTitle: String = "Try again"
    var onRetry: () -> Void

    var body: some View {
        VStack(spacing: SWSpacing.md) {
            ZStack {
                Circle()
                    .fill(Color.swDanger.opacity(0.12))
                    .frame(width: 88, height: 88)
                Image(systemName: "wifi.slash")
                    .font(.system(size: 32))
                    .foregroundStyle(Color.swDanger)
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
            SWButton(title: retryTitle, style: .primary, isFullWidth: false, action: onRetry)
        }
        .padding(SWSpacing.xl)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ErrorStateView {}
        .background(Color.swBackground)
}
