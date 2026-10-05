import SwiftUI

struct ProductCarousel: View {
    let products: [Product]
    var favoriteIds: Set<Int> = []
    var onToggleFavorite: ((Product) -> Void)? = nil
    var onSelect: (Product) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: SWSpacing.md) {
                ForEach(products) { product in
                    Button(action: { onSelect(product) }) {
                        ProductCard(
                            product: product,
                            isFavorite: favoriteIds.contains(product.id),
                            onToggleFavorite: onToggleFavorite.map { toggle in { toggle(product) } }
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, SWSpacing.md)
        }
    }
}

#Preview {
    ProductCarousel(products: MockData.products) { _ in }
        .padding(.vertical)
        .background(Color.swBackground)
}
