import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    @Environment(SessionStore.self) private var session
    @Environment(FavoritesStore.self) private var favorites
    @Environment(\.openRoute) private var openRoute
    @State private var searchText = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpacing.lg) {
                header

                Button { openRoute(.search) } label: {
                    SearchBar(text: .constant(""))
                        .allowsHitTesting(false)
                }
                .buttonStyle(.plain)
                .padding(.horizontal, SWSpacing.md)

                PromoBanner(title: "Weekend Deals", subtitle: "Up to 40% off today", action: { openRoute(.search) })
                    .padding(.horizontal, SWSpacing.md)

                if viewModel.isLoading && viewModel.categories.isEmpty {
                    loadingState
                } else if viewModel.loadError != nil, viewModel.categories.isEmpty {
                    ErrorStateView { Task { await viewModel.loadIfNeeded() } }
                } else {
                    content
                }
            }
            .padding(.vertical, SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded()
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Hey, \(session.currentUser?.firstName ?? "there") 👋")
                .font(.swLargeTitle)
                .foregroundStyle(Color.swTextPrimary)
            Text("Find your next favourite thing")
                .font(.swBody)
                .foregroundStyle(Color.swTextSecondary)
        }
        .padding(.horizontal, SWSpacing.md)
    }

    private var loadingState: some View {
        VStack(spacing: SWSpacing.md) {
            ShimmerView().frame(height: 120)
            ShimmerView().frame(height: 180)
        }
        .padding(.horizontal, SWSpacing.md)
    }

    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading, spacing: SWSpacing.sm) {
            SectionHeader(title: "Categories")
                .padding(.horizontal, SWSpacing.md)
            CategoryCarousel(categories: viewModel.categories) { category in
                openRoute(.category(slug: category.slug, title: category.name))
            }
        }

        SWSectionCard(
            title: "Deals for you",
            subtitle: "Up to 40% off today",
            icon: "flame.fill",
            tint: .swPrimary,
            actionTitle: "See all",
            action: { openRoute(.search) }
        ) {
            ProductCarousel(
                products: viewModel.dealProducts,
                favoriteIds: favoriteIds,
                onToggleFavorite: favorites.toggle,
                onSelect: { openRoute(.product($0.id)) }
            )
        }

        SWSectionCard(
            title: "Top rated",
            subtitle: "Loved by shoppers",
            icon: "star.fill",
            tint: .swGrape,
            actionTitle: "See all",
            action: { openRoute(.search) }
        ) {
            ProductCarousel(
                products: viewModel.topRatedProducts,
                favoriteIds: favoriteIds,
                onToggleFavorite: favorites.toggle,
                onSelect: { openRoute(.product($0.id)) }
            )
        }

        SWSectionCard(
            title: "Recently added",
            subtitle: "Fresh on Swappy",
            icon: "sparkles",
            tint: .swSky
        ) {
            VStack(spacing: 0) {
                ProductGrid(
                    products: viewModel.recentProducts,
                    favoriteIds: favoriteIds,
                    onToggleFavorite: favorites.toggle,
                    onSelect: { openRoute(.product($0.id)) },
                    onReachEnd: { Task { await viewModel.loadMoreRecentIfNeeded() } }
                )
                .padding(.horizontal, SWSpacing.md)

                if viewModel.isLoadingMore {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
        }
    }

    private var favoriteIds: Set<Int> {
        Set(favorites.products.map(\.id))
    }
}

#Preview {
    NavigationStack {
        HomeView()
            .withAppRouting()
    }
    .environment(SessionStore())
    .environment(CartStore())
    .environment(FavoritesStore())
}
