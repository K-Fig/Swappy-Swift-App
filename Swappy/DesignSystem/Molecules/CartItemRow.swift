import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    var onQuantityChange: (Int) -> Void
    var onRemove: () -> Void

    var body: some View {
        HStack(alignment: .top, spacing: SWSpacing.sm) {
            RemoteImage(url: item.product.thumbnailURL, cornerRadius: SWRadius.sm)
                .frame(width: 72, height: 72)

            VStack(alignment: .leading, spacing: 6) {
                Text(item.product.title)
                    .font(.swBodyEmphasis)
                    .foregroundStyle(Color.swTextPrimary)
                    .lineLimit(2)

                PriceTag(price: item.product.discountedPrice, originalPrice: item.product.hasDiscount ? item.product.price : nil, size: .swBodyEmphasis)

                HStack {
                    QuantityStepper(quantity: Binding(
                        get: { item.quantity },
                        set: { onQuantityChange($0) }
                    ))
                    Spacer()
                    Button(action: onRemove) {
                        Image(systemName: "trash")
                            .foregroundStyle(Color.swTextSecondary)
                    }
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        CartItemRow(item: MockData.cartItems[0], onQuantityChange: { _ in }, onRemove: {})
        SWDivider()
        CartItemRow(item: MockData.cartItems[1], onQuantityChange: { _ in }, onRemove: {})
    }
    .padding()
    .background(Color.swBackground)
}
