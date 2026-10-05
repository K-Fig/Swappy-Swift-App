import SwiftUI
import UIKit

struct SWIconButton: View {
    let icon: String
    var isActive: Bool = false
    var activeIcon: String? = nil
    var size: CGFloat = 44
    var tint: Color = .swTextPrimary
    var activeTint: Color = .swPrimary
    var action: () -> Void

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            action()
        }) {
            Image(systemName: isActive ? (activeIcon ?? icon) : icon)
                .font(.system(size: size * 0.42, weight: .semibold))
                .foregroundStyle(isActive ? activeTint : tint)
                .frame(width: size, height: size)
                .background(Color.swSurface)
                .clipShape(Circle())
                .swShadow(.soft)
        }
        .animation(.spring(duration: 0.3), value: isActive)
    }
}

#Preview {
    HStack(spacing: SWSpacing.md) {
        SWIconButton(icon: "heart", isActive: false, activeIcon: "heart.fill") {}
        SWIconButton(icon: "heart", isActive: true, activeIcon: "heart.fill") {}
        SWIconButton(icon: "square.and.arrow.up") {}
        SWIconButton(icon: "ellipsis") {}
    }
    .padding()
    .background(Color.swBackground)
}
