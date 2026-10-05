import SwiftUI

@main
struct SwappyApp: App {
    @State private var session = SessionStore()
    @State private var cart = CartStore()
    @State private var favorites = FavoritesStore()
    @State private var orders = OrdersStore()
    @State private var messages = MessagesStore()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environment(session)
                .environment(cart)
                .environment(favorites)
                .environment(orders)
                .environment(messages)
        }
    }
}
