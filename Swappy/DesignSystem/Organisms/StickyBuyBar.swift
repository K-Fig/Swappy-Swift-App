import SwiftUI

struct StickyBuyBar: View {
    let price: Double
    var originalPrice: Double? = nil
    var onMessageSeller: () -> Void
    var onAddToCart: () -> Void

    private var discountPercentage: Int? {
        guard let originalPrice, originalPrice > price else { return nil }
        return Int(((originalPrice - price) / originalPrice * 100).rounded())
    }

    var body: some View {
        HStack(spacing: SWSpacing.sm) {
            VStack(alignment: .leading, spacing: 2) {
                PriceTag(price: price, size: .swBodyEmphasis)
                if let discountPercentage {
                    SWBadge(text: "-\(discountPercentage)%", style: .discount)
                }
            }
            .layoutPriority(1)
            Spacer(minLength: SWSpacing.xs)
            SWIconButton(icon: "bubble.left.fill", action: onMessageSeller)
            SWButton(title: "Add to cart", icon: "cart.fill", style: .primary, isFullWidth: false, action: onAddToCart)
                .fixedSize(horizontal: true, vertical: false)
        }
        .padding(SWSpacing.md)
        .background(.ultraThinMaterial)
        .overlay(alignment: .top) {
            SWDivider()
        }
    }
}

#Preview {
    VStack {
        Spacer()
        StickyBuyBar(price: 39.99, originalPrice: 59.99, onMessageSeller: {}, onAddToCart: {})
    }
    .background(Color.swBackground)
}
