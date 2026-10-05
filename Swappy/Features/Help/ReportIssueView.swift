import SwiftUI

struct ReportIssueView: View {
    let orderId: Int
    @Environment(OrdersStore.self) private var ordersStore
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute
    @State private var selectedReason: String?
    @State private var seller: Seller?
    @State private var sellerMapper: SellerMapperProtocol = SellerMapper()

    private let reasons = [
        "Item not received",
        "Item damaged or defective",
        "Item doesn't match description",
        "Wrong item received",
        "Other",
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpacing.lg) {
            VStack(alignment: .leading, spacing: 4) {
                Text("What went wrong?")
                    .font(.swTitle)
                Text("Order #\(orderId)")
                    .font(.swCaption)
                    .foregroundStyle(Color.swTextSecondary)
            }

            VStack(spacing: SWSpacing.xs) {
                ForEach(reasons, id: \.self) { reason in
                    Button {
                        selectedReason = reason
                    } label: {
                        HStack {
                            Text(reason)
                                .font(.swBody)
                                .foregroundStyle(Color.swTextPrimary)
                            Spacer()
                            Image(systemName: selectedReason == reason ? "largecircle.fill.circle" : "circle")
                                .foregroundStyle(selectedReason == reason ? Color.swPrimary : Color.swBorder)
                        }
                        .padding(SWSpacing.sm)
                        .background(Color.swSurface)
                        .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()

            SWButton(title: "Start chat with seller", icon: "bubble.left.fill", style: .primary, isLoading: seller == nil && selectedReason != nil) {
                reportIssue()
            }
            .disabled(selectedReason == nil)
        }
        .padding(SWSpacing.md)
        .background(Color.swBackground)
        .navigationTitle("Report a problem")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            guard let order = ordersStore.order(id: orderId), let firstSellerId = order.sellerIds.first else { return }
            seller = try? await sellerMapper.seller(forSellerId: firstSellerId)
        }
    }

    private func reportIssue() {
        guard let seller, let reason = selectedReason else { return }
        let conversation = messages.startConversation(
            sellerId: seller.id,
            sellerName: seller.name,
            sellerAvatarURL: seller.avatarURL,
            orderContext: Conversation.OrderContext(orderId: orderId, reason: reason)
        )
        messages.sendMessage("Hi, I'm having an issue with order #\(orderId): \(reason).", in: conversation.id)
        openRoute(.chat(conversation.id))
    }
}

#Preview {
    NavigationStack {
        ReportIssueView(orderId: 1)
    }
    .environment(OrdersStore())
    .environment(MessagesStore())
}
