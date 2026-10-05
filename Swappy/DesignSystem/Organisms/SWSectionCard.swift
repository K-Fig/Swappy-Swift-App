import SwiftUI

struct SWSectionCard<Content: View>: View {
    let title: String
    var subtitle: String? = nil
    var icon: String
    var tint: Color
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil
    @ViewBuilder var content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpacing.sm) {
            HStack(spacing: SWSpacing.sm) {
                ZStack {
                    RoundedRectangle(cornerRadius: SWRadius.sm, style: .continuous)
                        .fill(tint.gradient)
                        .frame(width: 40, height: 40)
                    Image(systemName: icon)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundStyle(Color.swTextInverse)
                }

                VStack(alignment: .leading, spacing: 1) {
                    Text(title)
                        .font(.swTitle)
                        .foregroundStyle(Color.swTextPrimary)
                    if let subtitle {
                        Text(subtitle)
                            .font(.swCaption)
                            .foregroundStyle(Color.swTextSecondary)
                    }
                }

                Spacer()

                if let actionTitle, let action {
                    Button(action: action) {
                        Text(actionTitle)
                            .font(.swCaptionEmphasis)
                            .foregroundStyle(tint)
                            .padding(.horizontal, SWSpacing.xs)
                            .padding(.vertical, 6)
                            .background(tint.opacity(0.14))
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.horizontal, SWSpacing.md)

            content()
        }
        .padding(.vertical, SWSpacing.md)
        .background(
            RoundedRectangle(cornerRadius: SWRadius.xl, style: .continuous)
                .fill(tint.opacity(0.08))
        )
        .overlay(
            RoundedRectangle(cornerRadius: SWRadius.xl, style: .continuous)
                .stroke(tint.opacity(0.2), lineWidth: 1.5)
        )
        .swShadow(.tinted(tint))
        .padding(.horizontal, SWSpacing.md)
    }
}

#Preview {
    ScrollView {
        VStack(spacing: SWSpacing.lg) {
            SWSectionCard(title: "Deals for you", subtitle: "Up to 40% off today", icon: "flame.fill", tint: .swPrimary, actionTitle: "See all", action: {}) {
                ProductCarousel(products: MockData.products) { _ in }
            }
            SWSectionCard(title: "Top rated", subtitle: "Loved by shoppers", icon: "star.fill", tint: .swGrape, actionTitle: "See all", action: {}) {
                ProductCarousel(products: MockData.products) { _ in }
            }
        }
        .padding(.vertical)
    }
    .background(Color.swBackground)
}
