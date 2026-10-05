import Foundation

@Observable
@MainActor
final class FavoritesStore {
    private(set) var favoritesById: [Int: Product] = [:]

    var products: [Product] {
        Array(favoritesById.values).sorted { $0.title < $1.title }
    }

    var count: Int { favoritesById.count }

    func isFavorite(_ productId: Int) -> Bool {
        favoritesById[productId] != nil
    }

    func toggle(_ product: Product) {
        if favoritesById[product.id] != nil {
            favoritesById.removeValue(forKey: product.id)
        } else {
            favoritesById[product.id] = product
        }
    }
}
