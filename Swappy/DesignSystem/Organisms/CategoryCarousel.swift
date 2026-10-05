import SwiftUI

struct CategoryCarousel: View {
    let categories: [ProductCategory]
    var onSelect: (ProductCategory) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: SWSpacing.md) {
                ForEach(categories) { category in
                    CategoryTile(category: category) { onSelect(category) }
                }
            }
            .padding(.horizontal, SWSpacing.md)
        }
    }
}

#Preview {
    CategoryCarousel(categories: MockData.categories) { _ in }
        .padding(.vertical)
        .background(Color.swBackground)
}
