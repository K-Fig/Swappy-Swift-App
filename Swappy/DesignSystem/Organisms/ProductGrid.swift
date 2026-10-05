import SwiftUI

struct ProductGrid: View {
    let products: [Product]
    var favoriteIds: Set<Int> = []
    var onToggleFavorite: ((Product) -> Void)? = nil
    var onSelect: (Product) -> Void
    var onReachEnd: (() -> Void)? = nil

    private let columns = [GridItem(.flexible(), spacing: SWSpacing.sm), GridItem(.flexible(), spacing: SWSpacing.sm)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: SWSpacing.md) {
            ForEach(products) { product in
                Button(action: { onSelect(product) }) {
                    ProductCard(
                        product: product,
                        isFavorite: favoriteIds.contains(product.id),
                        onToggleFavorite: onToggleFavorite.map { toggle in { toggle(product) } }
                    )
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .buttonStyle(.plain)
                .onAppear {
                    if product.id == products.last?.id {
                        onReachEnd?()
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollView {
        ProductGrid(products: MockData.products, favoriteIds: [2]) { _ in }
            .padding()
    }
    .background(Color.swBackground)
}
