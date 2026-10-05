import SwiftUI

struct FavoritesListView: View {
    @Environment(FavoritesStore.self) private var favorites
    @Environment(\.openRoute) private var openRoute

    var body: some View {
        ScrollView {
            if favorites.products.isEmpty {
                EmptyStateView(icon: "heart", title: "No favourites yet", message: "Tap the heart on any listing to save it here.")
                    .padding(.top, 60)
            } else {
                ProductGrid(
                    products: favorites.products,
                    favoriteIds: Set(favorites.products.map(\.id)),
                    onToggleFavorite: favorites.toggle,
                    onSelect: { openRoute(.product($0.id)) }
                )
                .padding(SWSpacing.md)
            }
        }
        .background(Color.swBackground)
        .navigationTitle("Favourites")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FavoritesListView()
            .withAppRouting()
    }
    .environment(FavoritesStore())
}
