import SwiftUI

struct OrderConfirmationView: View {
    let orderId: Int
    @Environment(\.openRoute) private var openRoute
    @Environment(\.popToRoot) private var popToRoot

    var body: some View {
        VStack(spacing: SWSpacing.lg) {
            Spacer()

            ZStack {
                Circle()
                    .fill(LinearGradient.swFresh)
                    .frame(width: 100, height: 100)
                Image(systemName: "checkmark")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(Color.swTextInverse)
            }

            VStack(spacing: SWSpacing.xs) {
                Text("Order placed!")
                    .font(.swLargeTitle)
                    .foregroundStyle(Color.swTextPrimary)
                Text("Order #\(orderId) is on its way to processing.")
                    .font(.swBody)
                    .foregroundStyle(Color.swTextSecondary)
                    .multilineTextAlignment(.center)
            }

            Spacer()

            VStack(spacing: SWSpacing.sm) {
                SWButton(title: "View order", style: .primary) {
                    openRoute(.order(orderId))
                }
                SWButton(title: "Continue shopping", style: .secondary) {
                    popToRoot()
                }
            }
        }
        .padding(SWSpacing.lg)
        .background(Color.swBackground)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        OrderConfirmationView(orderId: 1)
            .withAppRouting()
    }
}
