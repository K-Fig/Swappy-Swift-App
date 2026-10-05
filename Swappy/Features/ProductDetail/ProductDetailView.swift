import SwiftUI

struct ProductDetailView: View {
    @State private var viewModel: ProductDetailViewModel
    @Environment(FavoritesStore.self) private var favorites
    @Environment(CartStore.self) private var cart
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute
    @State private var didAddToCart = false

    init(productId: Int) {
        _viewModel = State(initialValue: ProductDetailViewModel(productId: productId))
    }

    var body: some View {
        ScrollView {
            if let product = viewModel.product {
                VStack(alignment: .leading, spacing: SWSpacing.md) {
                    ImageCarousel(urls: product.imageURLs)

                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 4) {
                                if let brand = product.brand {
                                    Text(brand.uppercased())
                                        .font(.swCaptionEmphasis)
                                        .foregroundStyle(Color.swTextSecondary)
                                }
                                Text(product.title)
                                    .font(.swTitle)
                                    .foregroundStyle(Color.swTextPrimary)
                            }
                            Spacer()
                            SWIconButton(icon: "heart", isActive: favorites.isFavorite(product.id), activeIcon: "heart.fill") {
                                favorites.toggle(product)
                            }
                        }

                        RatingStars(rating: product.rating, reviewCount: product.reviews.count)
                        PriceTag(price: product.discountedPrice, originalPrice: product.hasDiscount ? product.price : nil)

                        HStack(spacing: SWSpacing.xs) {
                            SWBadge(text: product.isInStock ? "In stock" : "Out of stock", style: product.isInStock ? .success : .warning)
                            SWBadge(text: product.shippingInformation, style: .neutral)
                        }

                        SWDivider()

                        Text(product.description)
                            .font(.swBody)
                            .foregroundStyle(Color.swTextSecondary)

                        HStack(spacing: SWSpacing.xs) {
                            SWBadge(text: product.warrantyInformation, style: .neutral)
                            SWBadge(text: product.returnPolicy, style: .neutral)
                        }
                    }
                    .padding(.horizontal, SWSpacing.md)

                    if let seller = viewModel.seller {
                        SWDivider().padding(.horizontal, SWSpacing.md)
                        SellerCard(seller: seller, onMessage: { startChat(with: seller, product: product) }) {
                            openRoute(.seller(seller.id))
                        }
                        .padding(.horizontal, SWSpacing.md)
                    }

                    SWDivider().padding(.horizontal, SWSpacing.md)
                    ReviewList(reviews: product.reviews, averageRating: product.rating)
                        .padding(.horizontal, SWSpacing.md)

                    if !viewModel.moreFromSeller.isEmpty {
                        SWDivider().padding(.horizontal, SWSpacing.md)
                        VStack(alignment: .leading, spacing: SWSpacing.sm) {
                            SectionHeader(title: "More from this seller")
                                .padding(.horizontal, SWSpacing.md)
                            ProductCarousel(
                                products: viewModel.moreFromSeller,
                                favoriteIds: Set(favorites.products.map(\.id)),
                                onToggleFavorite: favorites.toggle,
                                onSelect: { openRoute(.product($0.id)) }
                            )
                        }
                    }

                    Spacer(minLength: 100)
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
        .safeAreaInset(edge: .bottom) {
            if let product = viewModel.product {
                StickyBuyBar(
                    price: product.discountedPrice,
                    originalPrice: product.hasDiscount ? product.price : nil,
                    onMessageSeller: {
                        if let seller = viewModel.seller {
                            startChat(with: seller, product: product)
                        }
                    },
                    onAddToCart: {
                        cart.add(product)
                        didAddToCart = true
                    }
                )
            }
        }
        .task {
            await viewModel.loadIfNeeded()
        }
        .sensoryFeedback(.success, trigger: didAddToCart)
    }

    private func startChat(with seller: Seller, product: Product) {
        let conversation = messages.startConversation(
            sellerId: seller.id,
            sellerName: seller.name,
            sellerAvatarURL: seller.avatarURL,
            productContext: Conversation.ProductContext(productId: product.id, productTitle: product.title, productThumbnail: product.thumbnail)
        )
        openRoute(.chat(conversation.id))
    }
}

#Preview {
    NavigationStack {
        ProductDetailView(productId: 2)
            .withAppRouting()
    }
    .environment(FavoritesStore())
    .environment(CartStore())
    .environment(MessagesStore())
}
