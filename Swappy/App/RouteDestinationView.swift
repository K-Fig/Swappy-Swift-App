import SwiftUI

struct RouteDestinationView: View {
    let route: Route

    var body: some View {
        switch route {
        case .search:
            ProductListView(mode: .search)
        case .product(let id):
            ProductDetailView(productId: id)
        case .category(let slug, let title):
            ProductListView(mode: .category(slug: slug, title: title))
        case .seller(let id):
            SellerProfileView(sellerId: id)
        case .order(let id):
            OrderDetailView(orderId: id)
        case .chat(let id):
            ChatView(conversationId: id)
        case .inbox:
            InboxView()
        case .ordersList:
            OrdersListView()
        case .favorites:
            FavoritesListView()
        case .help:
            HelpCenterView()
        case .faqDetail(let id):
            if let faq = MockData.faqs.first(where: { $0.id == id }) {
                FAQDetailView(faq: faq)
            }
        case .reportIssue(let orderId):
            ReportIssueView(orderId: orderId)
        case .checkout:
            CheckoutView()
        case .orderConfirmation(let id):
            OrderConfirmationView(orderId: id)
        }
    }
}

extension View {
    func withAppRouting() -> some View {
        navigationDestination(for: Route.self) { route in
            RouteDestinationView(route: route)
        }
    }
}
