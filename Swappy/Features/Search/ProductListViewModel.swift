import Foundation

enum PLPMode: Hashable {
    case search
    case category(slug: String, title: String)

    var title: String {
        switch self {
        case .search: "Search"
        case .category(_, let title): title
        }
    }
}

@Observable
@MainActor
final class ProductListViewModel {
    private(set) var products: [Product] = []
    private(set) var isLoading = false
    private(set) var isLoadingMore = false
    private(set) var loadError: Error?

    var query: String = "" {
        didSet { if oldValue != query { debounceReload() } }
    }
    var sortOption: ProductSortOption = .relevance {
        didSet { if oldValue != sortOption { applySort() } }
    }
    var filterState = ProductFilterState() {
        didSet { if oldValue != filterState { Task { await reload() } } }
    }

    let mode: PLPMode
    private let productService: ProductServiceProtocol
    private var skip = 0
    private var total = 0
    private let pageSize = 20
    private var searchDebounceTask: Task<Void, Never>?

    init(mode: PLPMode, productService: ProductServiceProtocol = ProductService()) {
        self.mode = mode
        self.productService = productService
    }

    func loadIfNeeded() async {
        guard products.isEmpty, !isLoading else { return }
        await reload()
    }

    private func debounceReload() {
        searchDebounceTask?.cancel()
        searchDebounceTask = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(300))
            guard !Task.isCancelled else { return }
            await self?.reload()
        }
    }

    func reload() async {
        isLoading = true
        loadError = nil
        skip = 0
        do {
            let response = try await fetchPage(skip: 0)
            products = filtered(response.products)
            total = response.total
            skip = response.products.count
        } catch {
            loadError = error
        }
        isLoading = false
    }

    func loadMoreIfNeeded(currentItem product: Product) async {
        guard product.id == products.last?.id, !isLoadingMore, skip < total else { return }
        isLoadingMore = true
        do {
            let response = try await fetchPage(skip: skip)
            products.append(contentsOf: filtered(response.products))
            skip += response.products.count
        } catch {
            // keep existing results; surface nothing disruptive for pagination failures
        }
        isLoadingMore = false
    }

    private func fetchPage(skip: Int) async throws -> ProductListResponse {
        switch mode {
        case .search:
            if query.trimmingCharacters(in: .whitespaces).isEmpty {
                return try await productService.fetchProducts(limit: pageSize, skip: skip)
            }
            return try await productService.searchProducts(query: query, limit: pageSize, skip: skip)
        case .category(let slug, _):
            return try await productService.fetchProducts(category: slug, limit: pageSize, skip: skip)
        }
    }

    private func filtered(_ products: [Product]) -> [Product] {
        var result = products
        if filterState.inStockOnly {
            result = result.filter(\.isInStock)
        }
        result = result.filter { $0.discountedPrice >= filterState.minPrice && $0.discountedPrice <= filterState.maxPrice }
        return sorted(result)
    }

    private func sorted(_ products: [Product]) -> [Product] {
        switch sortOption {
        case .relevance: products
        case .ratingHighToLow: products.sorted { $0.rating > $1.rating }
        case .priceLowToHigh: products.sorted { $0.discountedPrice < $1.discountedPrice }
        case .priceHighToLow: products.sorted { $0.discountedPrice > $1.discountedPrice }
        }
    }

    private func applySort() {
        products = sorted(products)
    }
}
