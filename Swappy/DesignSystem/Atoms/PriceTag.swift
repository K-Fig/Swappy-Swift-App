import SwiftUI

struct PriceTag: View {
    let price: Double
    var originalPrice: Double? = nil
    var size: Font = .swPrice

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: SWSpacing.xs) {
            Text(price, format: .currency(code: "USD"))
                .font(size)
                .foregroundStyle(Color.swTextPrimary)
            if let originalPrice, originalPrice > price {
                Text(originalPrice, format: .currency(code: "USD"))
                    .font(.swCaption)
                    .foregroundStyle(Color.swTextSecondary)
                    .strikethrough()
            }
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: SWSpacing.sm) {
        PriceTag(price: 49.99)
        PriceTag(price: 39.99, originalPrice: 59.99)
        PriceTag(price: 12.5, originalPrice: 15, size: .swBodyEmphasis)
    }
    .padding()
    .background(Color.swBackground)
}
