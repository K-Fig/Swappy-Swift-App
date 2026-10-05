import SwiftUI

enum SWStatusTone {
    case info
    case shipped
    case progress
    case success
    case neutral
    case danger

    var color: Color {
        switch self {
        case .info: .swStatusProcessing
        case .shipped: .swStatusShipped
        case .progress: .swStatusOutForDelivery
        case .success: .swSuccess
        case .neutral: .swStatusCancelled
        case .danger: .swDanger
        }
    }
}

struct StatusPill: View {
    let text: String
    let tone: SWStatusTone

    var body: some View {
        Text(text)
            .font(.swCaptionEmphasis)
            .padding(.horizontal, SWSpacing.sm)
            .padding(.vertical, 6)
            .foregroundStyle(tone.color)
            .background(tone.color.opacity(0.14))
            .clipShape(Capsule())
    }
}

#Preview {
    VStack(alignment: .leading, spacing: SWSpacing.xs) {
        StatusPill(text: "Processing", tone: .info)
        StatusPill(text: "Shipped", tone: .shipped)
        StatusPill(text: "Out for delivery", tone: .progress)
        StatusPill(text: "Delivered", tone: .success)
        StatusPill(text: "Cancelled", tone: .neutral)
        StatusPill(text: "Return requested", tone: .danger)
    }
    .padding()
    .background(Color.swBackground)
}
