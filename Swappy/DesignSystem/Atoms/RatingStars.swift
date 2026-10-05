import SwiftUI

struct RatingStars: View {
    let rating: Double
    var reviewCount: Int? = nil
    var size: CGFloat = 12

    var body: some View {
        HStack(spacing: 4) {
            HStack(spacing: 2) {
                ForEach(0..<5, id: \.self) { index in
                    Image(systemName: starName(for: index))
                        .font(.system(size: size))
                        .foregroundStyle(Color.swSecondary)
                }
            }
            Text(String(format: "%.1f", rating))
                .font(.swCaptionEmphasis)
                .foregroundStyle(Color.swTextPrimary)
            if let reviewCount {
                Text("(\(reviewCount))")
                    .font(.swCaption)
                    .foregroundStyle(Color.swTextSecondary)
            }
        }
    }

    private func starName(for index: Int) -> String {
        let filled = Double(index + 1)
        if rating >= filled {
            return "star.fill"
        } else if rating >= filled - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: SWSpacing.sm) {
        RatingStars(rating: 4.8, reviewCount: 231)
        RatingStars(rating: 3.5)
        RatingStars(rating: 2.1, reviewCount: 12, size: 16)
    }
    .padding()
    .background(Color.swBackground)
}
