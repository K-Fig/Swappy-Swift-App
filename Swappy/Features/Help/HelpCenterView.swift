import SwiftUI

struct HelpCenterView: View {
    @Environment(OrdersStore.self) private var ordersStore
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute
    @State private var query = ""
    @State private var selectedCategory: FAQCategory?
    @State private var showingOrderPicker = false

    private var filteredFAQs: [FAQ] {
        MockData.faqs.filter { faq in
            let matchesCategory = selectedCategory == nil || faq.category == selectedCategory
            let matchesQuery = query.isEmpty || faq.question.localizedCaseInsensitiveContains(query)
            return matchesCategory && matchesQuery
        }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpacing.lg) {
                SearchBar(text: $query, placeholder: "Search help articles")

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: SWSpacing.xs) {
                        SWChip(title: "All", isSelected: selectedCategory == nil) { selectedCategory = nil }
                        ForEach(FAQCategory.allCases) { category in
                            SWChip(title: category.rawValue, icon: category.icon, isSelected: selectedCategory == category) {
                                selectedCategory = category
                            }
                        }
                    }
                }

                VStack(alignment: .leading, spacing: SWSpacing.xs) {
                    if filteredFAQs.isEmpty {
                        EmptyStateView(icon: "questionmark.circle", title: "No articles found", message: "Try a different search term.")
                    } else {
                        ForEach(filteredFAQs) { faq in
                            FAQRow(faq: faq) { openRoute(.faqDetail(faq.id)) }
                            SWDivider()
                        }
                    }
                }

                VStack(spacing: SWSpacing.sm) {
                    SWButton(title: "Problem with an order?", icon: "shippingbox.fill", style: .secondary) {
                        showingOrderPicker = true
                    }
                    SWButton(title: "Contact Swappy support", icon: "bubble.left.and.bubble.right.fill", style: .outline) {
                        contactSupport()
                    }
                }
            }
            .padding(SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationTitle("Help Center")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await ordersStore.loadOrdersIfNeeded(userId: 1)
        }
        .sheet(isPresented: $showingOrderPicker) {
            OrderPickerSheet(orders: ordersStore.orders) { order in
                showingOrderPicker = false
                openRoute(.reportIssue(orderId: order.id))
            }
        }
    }

    private func contactSupport() {
        let conversation = messages.startConversation(
            sellerId: 0,
            sellerName: "Swappy Support",
            sellerAvatarURL: nil
        )
        openRoute(.chat(conversation.id))
    }
}

private struct OrderPickerSheet: View {
    let orders: [Order]
    let onSelect: (Order) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(orders) { order in
                Button {
                    onSelect(order)
                } label: {
                    HStack {
                        Text("Order #\(order.id)")
                        Spacer()
                        Text(order.placedDate.formatted(date: .abbreviated, time: .omitted))
                            .foregroundStyle(Color.swTextSecondary)
                    }
                }
            }
            .navigationTitle("Select an order")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HelpCenterView()
            .withAppRouting()
    }
    .environment(OrdersStore())
    .environment(MessagesStore())
}
