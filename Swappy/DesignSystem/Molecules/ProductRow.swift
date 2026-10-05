import SwiftUI

struct ProductRow: View {
    let product: Product
    var quantity: Int? = nil

    var body: some View {
        HStack(spacing: SWSpacing.sm) {
            RemoteImage(url: product.thumbnailURL, cornerRadius: SWRadius.sm)
                .frame(width: 64, height: 64)

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.swBodyEmphasis)
                    .foregroundStyle(Color.swTextPrimary)
                    .lineLimit(2)

                if let quantity {
                    Text("Qty: \(quantity)")
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                }

                PriceTag(price: product.discountedPrice, originalPrice: product.hasDiscount ? product.price : nil, size: .swBodyEmphasis)
            }

            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        ProductRow(product: MockData.products[0], quantity: 2)
        SWDivider()
        ProductRow(product: MockData.products[2])
    }
    .padding()
    .background(Color.swBackground)
}
