import SwiftUI

struct ShimmerView: View {
    var cornerRadius: CGFloat = SWRadius.md
    @State private var phase: CGFloat = -1

    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color.swSurfaceAlt)
            .overlay {
                GeometryReader { proxy in
                    LinearGradient(
                        colors: [.clear, .white.opacity(0.6), .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: proxy.size.width * 0.6)
                    .offset(x: phase * proxy.size.width * 1.6)
                }
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            }
            .onAppear {
                withAnimation(.linear(duration: 1.2).repeatForever(autoreverses: false)) {
                    phase = 1
                }
            }
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        ShimmerView()
            .frame(height: 160)
        HStack(spacing: SWSpacing.sm) {
            ShimmerView(cornerRadius: SWRadius.pill)
                .frame(width: 44, height: 44)
            VStack(alignment: .leading, spacing: SWSpacing.xxs) {
                ShimmerView().frame(height: 14)
                ShimmerView().frame(height: 14)
            }
        }
    }
    .padding()
    .background(Color.swBackground)
}
