import SwiftUI

struct RootTabView: View {
    @Environment(CartStore.self) private var cart
    @Environment(SessionStore.self) private var session

    @State private var homePath: [Route] = []
    @State private var searchPath: [Route] = []
    @State private var cartPath: [Route] = []
    @State private var inboxPath: [Route] = []
    @State private var profilePath: [Route] = []

    var body: some View {
        TabView {
            NavigationStack(path: $homePath) {
                HomeView()
                    .withAppRouting()
            }
            .environment(\.openRoute) { homePath.append($0) }
            .tabItem { Label("Home", systemImage: "house.fill") }

            NavigationStack(path: $searchPath) {
                ProductListView(mode: .search)
                    .withAppRouting()
            }
            .environment(\.openRoute) { searchPath.append($0) }
            .tabItem { Label("Search", systemImage: "magnifyingglass") }

            NavigationStack(path: $cartPath) {
                CartView()
                    .withAppRouting()
            }
            .environment(\.openRoute) { cartPath.append($0) }
            .environment(\.popToRoot) { cartPath.removeAll() }
            .tabItem { Label("Cart", systemImage: "cart.fill") }
            .badge(cart.itemCount > 0 ? "\(cart.itemCount)" : "")

            NavigationStack(path: $inboxPath) {
                InboxView()
                    .withAppRouting()
            }
            .environment(\.openRoute) { inboxPath.append($0) }
            .tabItem { Label("Inbox", systemImage: "bubble.left.and.bubble.right.fill") }

            NavigationStack(path: $profilePath) {
                UserProfileView()
                    .withAppRouting()
            }
            .environment(\.openRoute) { profilePath.append($0) }
            .tabItem { Label("Me", systemImage: "person.fill") }
        }
        .tint(.swPrimary)
        .task {
            await session.loadCurrentUserIfNeeded()
        }
    }
}

#Preview {
    RootTabView()
        .environment(SessionStore())
        .environment(CartStore())
        .environment(FavoritesStore())
        .environment(OrdersStore())
        .environment(MessagesStore())
}
