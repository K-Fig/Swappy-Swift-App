import SwiftUI

struct PromoBanner: View {
    let title: String
    let subtitle: String
    var icon: String = "sparkles"
    var gradient: LinearGradient = .swSunset
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.swTitle)
                        .foregroundStyle(Color.swTextInverse)
                    Text(subtitle)
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextInverse.opacity(0.9))
                }
                Spacer()
                Image(systemName: icon)
                    .font(.system(size: 40))
                    .foregroundStyle(Color.swTextInverse.opacity(0.85))
            }
            .padding(SWSpacing.md)
            .frame(maxWidth: .infinity)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: SWRadius.xl, style: .continuous))
            .swShadow(.tinted(.swPrimary))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        PromoBanner(title: "Weekend Deals", subtitle: "Up to 40% off electronics", action: {})
        PromoBanner(title: "New Arrivals", subtitle: "Fresh finds, just for you", icon: "leaf.fill", gradient: .swFresh, action: {})
    }
    .padding()
    .background(Color.swBackground)
}
