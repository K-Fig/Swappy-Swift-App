import SwiftUI

struct RemoteImage: View {
    let url: URL?
    var cornerRadius: CGFloat = SWRadius.md
    var contentMode: ContentMode = .fill

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeOut(duration: 0.25))) { phase in
            switch phase {
            case .empty:
                ShimmerView(cornerRadius: cornerRadius)
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            case .failure:
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .fill(Color.swSurfaceAlt)
                    Image(systemName: "photo")
                        .foregroundStyle(Color.swTextSecondary)
                }
            @unknown default:
                ShimmerView(cornerRadius: cornerRadius)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        RemoteImage(url: URL(string: "https://cdn.dummyjson.com/product-images/1/thumbnail.webp"))
            .frame(height: 180)
        RemoteImage(url: nil)
            .frame(height: 100)
    }
    .padding()
    .background(Color.swBackground)
}
