import SwiftUI
import UIKit

enum SWButtonStyle {
    case primary
    case secondary
    case outline
    case destructive
}

struct SWButton: View {
    let title: String
    var icon: String? = nil
    var style: SWButtonStyle = .primary
    var isFullWidth: Bool = true
    var isLoading: Bool = false
    var action: () -> Void

    var body: some View {
        Button(action: {
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            action()
        }) {
            HStack(spacing: SWSpacing.xs) {
                if isLoading {
                    ProgressView()
                        .tint(foreground)
                } else {
                    if let icon {
                        Image(systemName: icon)
                    }
                    Text(title)
                        .font(.swBodyEmphasis)
                }
            }
            .frame(maxWidth: isFullWidth ? .infinity : nil)
            .frame(height: 52)
            .padding(.horizontal, SWSpacing.md)
            .foregroundStyle(foreground)
            .background(background)
            .overlay {
                if style == .outline {
                    RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous)
                        .stroke(Color.swPrimary, lineWidth: 2)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
        }
        .disabled(isLoading)
        .animation(.spring(duration: 0.25), value: isLoading)
    }

    private var foreground: Color {
        switch style {
        case .primary, .destructive: .swTextInverse
        case .secondary: .swTextPrimary
        case .outline: .swPrimary
        }
    }

    @ViewBuilder
    private var background: some View {
        switch style {
        case .primary: LinearGradient.swSunset
        case .secondary: Color.swSurfaceAlt
        case .outline: Color.clear
        case .destructive: Color.swDanger
        }
    }
}

#Preview {
    VStack(spacing: SWSpacing.sm) {
        SWButton(title: "Add to cart", icon: "cart.fill", style: .primary) {}
        SWButton(title: "Message seller", style: .secondary) {}
        SWButton(title: "View details", style: .outline) {}
        SWButton(title: "Remove item", style: .destructive) {}
        SWButton(title: "Placing order", style: .primary, isLoading: true) {}
    }
    .padding()
    .background(Color.swBackground)
}
