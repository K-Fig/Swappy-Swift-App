import SwiftUI

struct OrderDetailView: View {
    let orderId: Int
    @Environment(OrdersStore.self) private var ordersStore
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute
    @State private var seller: Seller?
    @State private var sellerMapper: SellerMapperProtocol = SellerMapper()

    private var order: Order? {
        ordersStore.order(id: orderId)
    }

    var body: some View {
        ScrollView {
            if let order {
                VStack(alignment: .leading, spacing: SWSpacing.lg) {
                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        HStack {
                            Text("Order #\(order.id)")
                                .font(.swTitle)
                            Spacer()
                            StatusPill(text: order.status.label, tone: order.status.tone)
                        }
                        Text("Placed \(order.placedDate.formatted(date: .long, time: .shortened))")
                            .font(.swCaption)
                            .foregroundStyle(Color.swTextSecondary)
                    }

                    OrderTimeline(status: order.status, placedDate: order.placedDate)

                    if let seller {
                        SWDivider()
                        SellerCard(seller: seller, onMessage: { contactSeller(seller) }) {
                            openRoute(.seller(seller.id))
                        }
                    }

                    SWDivider()

                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        SectionHeader(title: "Items")
                        ForEach(order.items) { item in
                            HStack(spacing: SWSpacing.sm) {
                                RemoteImage(url: item.thumbnailURL, cornerRadius: SWRadius.sm)
                                    .frame(width: 56, height: 56)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(item.title)
                                        .font(.swBodyEmphasis)
                                        .lineLimit(2)
                                    Text("Qty \(item.quantity)")
                                        .font(.swCaption)
                                        .foregroundStyle(Color.swTextSecondary)
                                }
                                Spacer()
                                PriceTag(price: item.lineTotal, size: .swBodyEmphasis)
                            }
                        }
                    }

                    OrderSummaryCard(subtotal: order.total, discount: order.total - order.discountedTotal, shipping: 0)

                    VStack(spacing: SWSpacing.sm) {
                        if let seller {
                            SWButton(title: "Contact seller", icon: "bubble.left.fill", style: .secondary) {
                                contactSeller(seller)
                            }
                        }
                        SWButton(title: "Report a problem", icon: "exclamationmark.triangle.fill", style: .outline) {
                            openRoute(.reportIssue(orderId: order.id))
                        }
                    }
                }
                .padding(SWSpacing.md)
            } else {
                EmptyStateView(icon: "questionmark.folder", title: "Order not found", message: "This order could not be loaded.")
                    .padding(.top, 80)
            }
        }
        .background(Color.swBackground)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            guard let order, let firstSellerId = order.sellerIds.first else { return }
            seller = try? await sellerMapper.seller(forSellerId: firstSellerId)
        }
    }

    private func contactSeller(_ seller: Seller) {
        let conversation = messages.startConversation(
            sellerId: seller.id,
            sellerName: seller.name,
            sellerAvatarURL: seller.avatarURL,
            orderContext: Conversation.OrderContext(orderId: orderId, reason: "Order #\(orderId)")
        )
        openRoute(.chat(conversation.id))
    }
}

#Preview {
    NavigationStack {
        OrderDetailView(orderId: MockData.orders[0].id)
            .withAppRouting()
    }
    .environment(OrdersStore())
    .environment(MessagesStore())
}
