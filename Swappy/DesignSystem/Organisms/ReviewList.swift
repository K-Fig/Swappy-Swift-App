import SwiftUI

struct ReviewList: View {
    let reviews: [Review]
    var averageRating: Double
    var limit: Int = 3

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpacing.sm) {
            HStack {
                Text("Reviews")
                    .font(.swHeadline)
                    .foregroundStyle(Color.swTextPrimary)
                Spacer()
                RatingStars(rating: averageRating, reviewCount: reviews.count)
            }

            if reviews.isEmpty {
                Text("No reviews yet.")
                    .font(.swBody)
                    .foregroundStyle(Color.swTextSecondary)
            } else {
                ForEach(reviews.prefix(limit)) { review in
                    ReviewCard(review: review)
                }
            }
        }
    }
}

#Preview {
    ReviewList(reviews: MockData.reviews, averageRating: 4.2)
        .padding()
        .background(Color.swBackground)
}
