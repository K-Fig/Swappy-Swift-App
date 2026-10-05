import SwiftUI

struct SellerProfileView: View {
    @State private var viewModel: SellerProfileViewModel
    @Environment(FavoritesStore.self) private var favorites
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute

    init(sellerId: Int) {
        _viewModel = State(initialValue: SellerProfileViewModel(sellerId: sellerId))
    }

    var body: some View {
        ScrollView {
            if let seller = viewModel.seller {
                VStack(alignment: .leading, spacing: SWSpacing.lg) {
                    ProfileHeader(
                        name: seller.name,
                        subtitle: "\(seller.city), \(seller.country)",
                        avatarURL: seller.avatarURL,
                        initials: seller.initials,
                        stats: [
                            ("\(seller.listingsCount)", "Listings"),
                            (String(format: "%.1f", seller.rating), "Rating"),
                        ]
                    )
                    .padding(.horizontal, SWSpacing.md)

                    SWButton(title: "Message seller", icon: "bubble.left.fill", style: .primary) {
                        let conversation = messages.startConversation(
                            sellerId: seller.id,
                            sellerName: seller.name,
                            sellerAvatarURL: seller.avatarURL
                        )
                        openRoute(.chat(conversation.id))
                    }
                    .padding(.horizontal, SWSpacing.md)

                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        SectionHeader(title: "Listings")
                            .padding(.horizontal, SWSpacing.md)
                        if viewModel.listings.isEmpty {
                            EmptyStateView(icon: "shippingbox", title: "No listings yet", message: "This seller hasn't listed anything.")
                        } else {
                            ProductGrid(
                                products: viewModel.listings,
                                favoriteIds: Set(favorites.products.map(\.id)),
                                onToggleFavorite: favorites.toggle,
                                onSelect: { openRoute(.product($0.id)) }
                            )
                            .padding(.horizontal, SWSpacing.md)
                        }
                    }
                }
                .padding(.vertical, SWSpacing.md)
            } else if viewModel.isLoading {
                ProgressView().padding(.top, 100)
            } else if viewModel.loadError != nil {
                ErrorStateView { Task { await viewModel.loadIfNeeded() } }
                    .padding(.top, 60)
            }
        }
        .background(Color.swBackground)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded()
        }
    }
}

#Preview {
    NavigationStack {
        SellerProfileView(sellerId: 7)
            .withAppRouting()
    }
    .environment(FavoritesStore())
    .environment(MessagesStore())
}
