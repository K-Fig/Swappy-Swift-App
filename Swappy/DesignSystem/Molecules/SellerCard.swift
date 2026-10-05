import SwiftUI

struct SellerCard: View {
    let seller: Seller
    var onMessage: (() -> Void)? = nil
    var onTap: (() -> Void)? = nil

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: SWSpacing.sm) {
                AvatarView(url: seller.avatarURL, initials: seller.initials, size: 48)

                VStack(alignment: .leading, spacing: 2) {
                    Text(seller.name)
                        .font(.swBodyEmphasis)
                        .foregroundStyle(Color.swTextPrimary)
                    RatingStars(rating: seller.rating, size: 10)
                    Text("\(seller.listingsCount) listings · \(seller.city)")
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                }

                Spacer()

                if let onMessage {
                    SWButton(title: "Message", style: .outline, isFullWidth: false, action: onMessage)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        SellerCard(seller: MockData.seller, onMessage: {}, onTap: {})
        SellerCard(seller: MockData.seller)
    }
    .padding()
    .background(Color.swBackground)
}
