import SwiftUI

struct ReviewCard: View {
    let review: Review

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpacing.xxs) {
            HStack(spacing: SWSpacing.xs) {
                AvatarView(url: nil, initials: initials, size: 32)
                VStack(alignment: .leading, spacing: 2) {
                    Text(review.reviewerName)
                        .font(.swCaptionEmphasis)
                        .foregroundStyle(Color.swTextPrimary)
                    RatingStars(rating: Double(review.rating), size: 10)
                }
                Spacer()
            }
            Text(review.comment)
                .font(.swBody)
                .foregroundStyle(Color.swTextSecondary)
        }
        .padding(SWSpacing.sm)
        .background(Color.swSurface)
        .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
        .swShadow(.soft)
    }

    private var initials: String {
        let parts = review.reviewerName.split(separator: " ")
        return parts.prefix(2).compactMap { $0.first.map(String.init) }.joined().uppercased()
    }
}

#Preview {
    VStack(spacing: SWSpacing.sm) {
        ForEach(MockData.reviews) { review in
            ReviewCard(review: review)
        }
    }
    .padding()
    .background(Color.swBackground)
}
