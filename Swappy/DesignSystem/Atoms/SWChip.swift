import SwiftUI

struct SWChip: View {
    let title: String
    var icon: String? = nil
    var isSelected: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: SWSpacing.xxs) {
                if let icon {
                    Image(systemName: icon)
                        .font(.caption)
                }
                Text(title)
                    .font(.swCaptionEmphasis)
            }
            .padding(.horizontal, SWSpacing.sm)
            .padding(.vertical, SWSpacing.xs)
            .foregroundStyle(isSelected ? Color.swTextInverse : Color.swTextPrimary)
            .background(isSelected ? AnyShapeStyle(LinearGradient.swSunset) : AnyShapeStyle(Color.swSurfaceAlt))
            .clipShape(Capsule())
        }
        .animation(.spring(duration: 0.2), value: isSelected)
    }
}

#Preview {
    HStack(spacing: SWSpacing.xs) {
        SWChip(title: "Electronics", isSelected: true) {}
        SWChip(title: "Price", icon: "chevron.down", isSelected: false) {}
        SWChip(title: "In stock", isSelected: false) {}
    }
    .padding()
    .background(Color.swBackground)
}
