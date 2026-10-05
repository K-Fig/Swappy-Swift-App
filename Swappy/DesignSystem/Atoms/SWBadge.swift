import SwiftUI

enum SWBadgeStyle {
    case discount
    case new
    case success
    case warning
    case neutral
}

struct SWBadge: View {
    let text: String
    var style: SWBadgeStyle = .neutral

    var body: some View {
        Text(text)
            .font(.swCaptionEmphasis)
            .padding(.horizontal, SWSpacing.xs)
            .padding(.vertical, 4)
            .foregroundStyle(foreground)
            .background(background)
            .clipShape(Capsule())
    }

    private var foreground: Color {
        switch style {
        case .discount, .success: .swTextInverse
        case .new: .swTextInverse
        case .warning: .swTextPrimary
        case .neutral: .swTextSecondary
        }
    }

    private var background: Color {
        switch style {
        case .discount: .swDanger
        case .new: .swGrape
        case .success: .swSuccess
        case .warning: .swWarning
        case .neutral: .swSurfaceAlt
        }
    }
}

#Preview {
    HStack(spacing: SWSpacing.xs) {
        SWBadge(text: "-20%", style: .discount)
        SWBadge(text: "NEW", style: .new)
        SWBadge(text: "In stock", style: .success)
        SWBadge(text: "Low stock", style: .warning)
        SWBadge(text: "Free ship", style: .neutral)
    }
    .padding()
    .background(Color.swBackground)
}
