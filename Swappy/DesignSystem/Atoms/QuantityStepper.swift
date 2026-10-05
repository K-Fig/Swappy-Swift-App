import SwiftUI

struct QuantityStepper: View {
    @Binding var quantity: Int
    var range: ClosedRange<Int> = 1...99

    var body: some View {
        HStack(spacing: 0) {
            stepButton(icon: "minus") {
                quantity = max(range.lowerBound, quantity - 1)
            }
            .disabled(quantity <= range.lowerBound)

            Text("\(quantity)")
                .font(.swBodyEmphasis)
                .frame(minWidth: 32)

            stepButton(icon: "plus") {
                quantity = min(range.upperBound, quantity + 1)
            }
            .disabled(quantity >= range.upperBound)
        }
        .padding(.horizontal, SWSpacing.xs)
        .frame(height: 40)
        .background(Color.swSurfaceAlt)
        .clipShape(Capsule())
        .animation(.spring(duration: 0.2), value: quantity)
    }

    private func stepButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(Color.swTextPrimary)
                .frame(width: 28, height: 28)
        }
    }
}

#Preview {
    QuantityStepper(quantity: .constant(2))
        .padding()
        .background(Color.swBackground)
}
