import SwiftUI

struct OrderTimeline: View {
    let status: OrderStatus
    let placedDate: Date

    private var steps: [OrderStatus] { [.processing, .shipped, .outForDelivery, .delivered] }

    var body: some View {
        if status == .cancelled {
            HStack(spacing: SWSpacing.sm) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(Color.swDanger)
                Text("This order was cancelled")
                    .font(.swBodyEmphasis)
                    .foregroundStyle(Color.swTextPrimary)
            }
            .padding(SWSpacing.md)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.swDanger.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
        } else {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(steps.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: SWSpacing.sm) {
                        VStack(spacing: 0) {
                            Circle()
                                .fill(isComplete(step) ? AnyShapeStyle(LinearGradient.swSunset) : AnyShapeStyle(Color.swBorder))
                                .frame(width: 20, height: 20)
                                .overlay {
                                    if isComplete(step) {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 10, weight: .bold))
                                            .foregroundStyle(Color.swTextInverse)
                                    }
                                }
                            if index < steps.count - 1 {
                                Rectangle()
                                    .fill(isComplete(steps[index + 1]) ? Color.swPrimary : Color.swBorder)
                                    .frame(width: 2, height: 32)
                            }
                        }

                        VStack(alignment: .leading, spacing: 2) {
                            Text(step.label)
                                .font(.swBodyEmphasis)
                                .foregroundStyle(isComplete(step) ? Color.swTextPrimary : Color.swTextSecondary)
                            if step == .processing {
                                Text(placedDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.swCaption)
                                    .foregroundStyle(Color.swTextSecondary)
                            }
                        }
                        .padding(.bottom, SWSpacing.sm)

                        Spacer()
                    }
                }
            }
        }
    }

    private func isComplete(_ step: OrderStatus) -> Bool {
        guard let currentIndex = steps.firstIndex(of: status), let stepIndex = steps.firstIndex(of: step) else { return false }
        return stepIndex <= currentIndex
    }
}

#Preview {
    VStack(spacing: SWSpacing.lg) {
        OrderTimeline(status: .shipped, placedDate: .now)
        OrderTimeline(status: .cancelled, placedDate: .now)
    }
    .padding()
    .background(Color.swBackground)
}
