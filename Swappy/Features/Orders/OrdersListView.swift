import SwiftUI

struct OrdersListView: View {
    @Environment(OrdersStore.self) private var orders
    @Environment(\.openRoute) private var openRoute
    @State private var statusFilter: OrderStatus?

    private var filteredOrders: [Order] {
        guard let statusFilter else { return orders.orders }
        return orders.orders.filter { $0.status == statusFilter }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: SWSpacing.md) {
                Picker("Status", selection: $statusFilter) {
                    Text("All").tag(OrderStatus?.none)
                    ForEach(OrderStatus.allCases, id: \.self) { status in
                        Text(status.label).tag(OrderStatus?.some(status))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, SWSpacing.md)

                if orders.isLoading && orders.orders.isEmpty {
                    ProgressView().padding(.top, 60)
                } else if filteredOrders.isEmpty {
                    EmptyStateView(icon: "shippingbox", title: "No orders here", message: "Orders matching this status will show up here.")
                        .padding(.top, 40)
                } else {
                    VStack(spacing: SWSpacing.md) {
                        ForEach(filteredOrders) { order in
                            OrderCard(order: order) { openRoute(.order(order.id)) }
                        }
                    }
                    .padding(.horizontal, SWSpacing.md)
                }
            }
            .padding(.vertical, SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationTitle("My Orders")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await orders.loadOrdersIfNeeded(userId: 1)
        }
    }
}

#Preview {
    NavigationStack {
        OrdersListView()
            .withAppRouting()
    }
    .environment(OrdersStore())
}
