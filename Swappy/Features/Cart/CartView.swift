import SwiftUI

struct CartView: View {
    @Environment(CartStore.self) private var cart
    @Environment(\.openRoute) private var openRoute

    var body: some View {
        ScrollView {
            if cart.items.isEmpty {
                if cart.isSeeding {
                    ProgressView().padding(.top, 100)
                } else {
                    EmptyStateView(icon: "cart", title: "Your cart is empty", message: "Browse Swappy and add something you love.")
                        .padding(.top, 60)
                }
            } else {
                VStack(spacing: SWSpacing.lg) {
                    VStack(spacing: SWSpacing.md) {
                        ForEach(cart.items) { item in
                            CartItemRow(
                                item: item,
                                onQuantityChange: { cart.setQuantity(productId: item.id, quantity: $0) },
                                onRemove: { cart.remove(productId: item.id) }
                            )
                        }
                    }
                    .padding(.horizontal, SWSpacing.md)

                    OrderSummaryCard(subtotal: cart.subtotal, discount: cart.discount, shipping: 0)
                        .padding(.horizontal, SWSpacing.md)

                    SWButton(title: "Proceed to checkout", icon: "lock.fill", style: .primary) {
                        openRoute(.checkout)
                    }
                    .padding(.horizontal, SWSpacing.md)
                }
                .padding(.vertical, SWSpacing.md)
            }
        }
        .background(Color.swBackground)
        .navigationTitle("Cart")
        .task {
            await cart.seedFromRemoteCart(userId: 1)
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
            .withAppRouting()
    }
    .environment(CartStore())
}
