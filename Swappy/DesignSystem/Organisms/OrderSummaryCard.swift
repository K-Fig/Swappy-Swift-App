import SwiftUI

struct OrderSummaryCard: View {
    let subtotal: Double
    let discount: Double
    let shipping: Double
    var title: String = "Order summary"

    var total: Double { subtotal - discount + shipping }

    var body: some View {
        VStack(spacing: SWSpacing.sm) {
            Text(title)
                .font(.swHeadline)
                .foregroundStyle(Color.swTextPrimary)
                .frame(maxWidth: .infinity, alignment: .leading)

            summaryRow("Subtotal", subtotal)
            if discount > 0 {
                summaryRow("Discount", -discount, tint: .swSuccess)
            }
            summaryRow(shipping == 0 ? "Shipping (Free)" : "Shipping", shipping)
            SWDivider()
            HStack {
                Text("Total")
                    .font(.swBodyEmphasis)
                Spacer()
                PriceTag(price: total, size: .swBodyEmphasis)
            }
        }
        .padding(SWSpacing.md)
        .background(Color.swSurface)
        .clipShape(RoundedRectangle(cornerRadius: SWRadius.lg, style: .continuous))
        .swShadow(.card)
    }

    private func summaryRow(_ label: String, _ amount: Double, tint: Color = .swTextSecondary) -> some View {
        HStack {
            Text(label)
                .font(.swBody)
                .foregroundStyle(Color.swTextSecondary)
            Spacer()
            Text(amount, format: .currency(code: "USD"))
                .font(.swBody)
                .foregroundStyle(tint)
        }
    }
}

#Preview {
    OrderSummaryCard(subtotal: 588.98, discount: 75.56, shipping: 0)
        .padding()
        .background(Color.swBackground)
}
