import SwiftUI

struct OrderCard: View {
    let order: Order
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: SWSpacing.sm) {
                HStack {
                    Text("Order #\(order.id)")
                        .font(.swCaptionEmphasis)
                        .foregroundStyle(Color.swTextSecondary)
                    Spacer()
                    StatusPill(text: order.status.label, tone: order.status.tone)
                }

                HStack(spacing: -12) {
                    ForEach(Array(order.items.prefix(4).enumerated()), id: \.offset) { _, item in
                        RemoteImage(url: item.thumbnailURL, cornerRadius: SWRadius.sm)
                            .frame(width: 56, height: 56)
                            .overlay(RoundedRectangle(cornerRadius: SWRadius.sm, style: .continuous).stroke(Color.swSurface, lineWidth: 2))
                    }
                }

                HStack {
                    Text("\(order.itemCount) item\(order.itemCount == 1 ? "" : "s") · \(order.placedDate.formatted(date: .abbreviated, time: .omitted))")
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                    Spacer()
                    PriceTag(price: order.discountedTotal, size: .swBodyEmphasis)
                }
            }
            .padding(SWSpacing.md)
            .background(Color.swSurface)
            .clipShape(RoundedRectangle(cornerRadius: SWRadius.lg, style: .continuous))
            .swShadow(.card)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        ForEach(MockData.orders) { order in
            OrderCard(order: order) {}
        }
    }
    .padding()
    .background(Color.swBackground)
}
