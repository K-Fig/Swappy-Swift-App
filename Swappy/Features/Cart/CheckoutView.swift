import SwiftUI

struct CheckoutView: View {
    @Environment(CartStore.self) private var cart
    @Environment(OrdersStore.self) private var orders
    @Environment(SessionStore.self) private var session
    @Environment(\.openRoute) private var openRoute
    @State private var isPlacingOrder = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpacing.lg) {
                VStack(alignment: .leading, spacing: SWSpacing.sm) {
                    SectionHeader(title: "Shipping address")
                    VStack(alignment: .leading, spacing: 4) {
                        Text(session.currentUser?.fullName ?? "Guest")
                            .font(.swBodyEmphasis)
                        Text(session.currentUser?.formattedAddress ?? "No address on file")
                            .font(.swBody)
                            .foregroundStyle(Color.swTextSecondary)
                    }
                    .padding(SWSpacing.md)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.swSurface)
                    .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
                    .swShadow(.soft)
                }

                VStack(alignment: .leading, spacing: SWSpacing.sm) {
                    SectionHeader(title: "Payment")
                    HStack {
                        Image(systemName: "creditcard.fill")
                            .foregroundStyle(Color.swPrimary)
                        Text("Visa •••• 4242")
                            .font(.swBody)
                        Spacer()
                        SWBadge(text: "Default", style: .neutral)
                    }
                    .padding(SWSpacing.md)
                    .background(Color.swSurface)
                    .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
                    .swShadow(.soft)
                }

                VStack(alignment: .leading, spacing: SWSpacing.sm) {
                    SectionHeader(title: "Items")
                    ForEach(cart.items) { item in
                        ProductRow(product: item.product, quantity: item.quantity)
                    }
                }

                OrderSummaryCard(subtotal: cart.subtotal, discount: cart.discount, shipping: 0)

                SWButton(title: "Place order", icon: "checkmark.seal.fill", style: .primary, isLoading: isPlacingOrder) {
                    placeOrder()
                }
            }
            .padding(SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func placeOrder() {
        isPlacingOrder = true
        let order = orders.placeOrder(from: cart.items)
        cart.clear()
        isPlacingOrder = false
        openRoute(.orderConfirmation(order.id))
    }
}

#Preview {
    NavigationStack {
        CheckoutView()
            .withAppRouting()
    }
    .environment(CartStore())
    .environment(OrdersStore())
    .environment(SessionStore())
}
