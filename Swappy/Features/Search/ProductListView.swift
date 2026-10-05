import SwiftUI

struct ProductListView: View {
    @State private var viewModel: ProductListViewModel
    @Environment(FavoritesStore.self) private var favorites
    @Environment(\.openRoute) private var openRoute

    init(mode: PLPMode) {
        _viewModel = State(initialValue: ProductListViewModel(mode: mode))
    }

    var body: some View {
        VStack(spacing: 0) {
            if case .search = viewModel.mode {
                SearchBar(text: Binding(get: { viewModel.query }, set: { viewModel.query = $0 }), onSubmit: {
                    Task { await viewModel.reload() }
                })
                .padding(.horizontal, SWSpacing.md)
                .padding(.top, SWSpacing.xs)
            }

            SortFilterBar(
                sortOption: Binding(get: { viewModel.sortOption }, set: { viewModel.sortOption = $0 }),
                filterState: Binding(get: { viewModel.filterState }, set: { viewModel.filterState = $0 })
            )
            .padding(.horizontal, SWSpacing.md)
            .padding(.top, SWSpacing.sm)

            ScrollView {
                if viewModel.isLoading && viewModel.products.isEmpty {
                    gridSkeleton
                } else if viewModel.loadError != nil, viewModel.products.isEmpty {
                    ErrorStateView { Task { await viewModel.reload() } }
                } else if viewModel.products.isEmpty {
                    EmptyStateView(icon: "magnifyingglass", title: "No results", message: "Try a different search or adjust your filters.")
                } else {
                    ProductGrid(
                        products: viewModel.products,
                        favoriteIds: Set(favorites.products.map(\.id)),
                        onToggleFavorite: favorites.toggle,
                        onSelect: { openRoute(.product($0.id)) },
                        onReachEnd: {
                            if let last = viewModel.products.last {
                                Task { await viewModel.loadMoreIfNeeded(currentItem: last) }
                            }
                        }
                    )
                    .padding(SWSpacing.md)

                    if viewModel.isLoadingMore {
                        ProgressView().padding()
                    }
                }
            }
        }
        .background(Color.swBackground)
        .navigationTitle(viewModel.mode.title)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadIfNeeded()
        }
    }

    private var gridSkeleton: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: SWSpacing.md) {
            ForEach(0..<6, id: \.self) { _ in
                VStack(alignment: .leading, spacing: SWSpacing.xs) {
                    ShimmerView().aspectRatio(1, contentMode: .fit)
                    ShimmerView().frame(height: 14)
                    ShimmerView().frame(height: 14).frame(width: 80)
                }
            }
        }
        .padding(SWSpacing.md)
    }
}

#Preview {
    NavigationStack {
        ProductListView(mode: .search)
            .withAppRouting()
    }
    .environment(FavoritesStore())
}
