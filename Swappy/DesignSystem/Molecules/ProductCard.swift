import SwiftUI

struct ProductCard: View {
    let product: Product
    var isFavorite: Bool = false
    var onToggleFavorite: (() -> Void)? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpacing.xs) {
            ZStack(alignment: .topTrailing) {
                RemoteImage(url: product.thumbnailURL, cornerRadius: SWRadius.md)
                    .aspectRatio(1, contentMode: .fit)

                if product.hasDiscount {
                    SWBadge(text: "-\(Int(product.discountPercentage))%", style: .discount)
                        .padding(SWSpacing.xs)
                }

                if let onToggleFavorite {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            SWIconButton(icon: "heart", isActive: isFavorite, activeIcon: "heart.fill", size: 32, action: onToggleFavorite)
                        }
                    }
                    .padding(SWSpacing.xs)
                }
            }

            Text(product.title)
                .font(.swCaptionEmphasis)
                .foregroundStyle(Color.swTextPrimary)
                .lineLimit(2)
                .frame(height: 32, alignment: .top)

            RatingStars(rating: product.rating, size: 10)

            PriceTag(price: product.discountedPrice, originalPrice: product.hasDiscount ? product.price : nil, size: .swBodyEmphasis)
        }
        .frame(width: 160, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: SWSpacing.md) {
            ProductCard(product: MockData.products[0], isFavorite: true) {}
            ProductCard(product: MockData.products[1]) {}
            ProductCard(product: MockData.products[9])
        }
        .padding()
    }
    .background(Color.swBackground)
}
