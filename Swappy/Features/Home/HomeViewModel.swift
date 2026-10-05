import Foundation

@Observable
@MainActor
final class HomeViewModel {
    private(set) var categories: [ProductCategory] = []
    private(set) var dealProducts: [Product] = []
    private(set) var topRatedProducts: [Product] = []
    private(set) var recentProducts: [Product] = []
    private(set) var isLoading = false
    private(set) var loadError: Error?
    private(set) var isLoadingMore = false

    private let productService: ProductServiceProtocol
    private var recentSkip = 0
    private let pageSize = 10
    private var hasMoreRecent = true

    init(productService: ProductServiceProtocol = ProductService()) {
        self.productService = productService
    }

    func loadIfNeeded() async {
        guard categories.isEmpty, !isLoading else { return }
        isLoading = true
        loadError = nil
        do {
            async let categoriesTask = productService.fetchCategories()
            async let catalogTask = productService.fetchProducts(limit: 0, skip: 0)
            async let recentTask = productService.fetchProducts(limit: pageSize, skip: 0)
            let (categories, catalog, recent) = try await (categoriesTask, catalogTask, recentTask)
            self.categories = categories
            dealProducts = catalog.products
                .filter { $0.hasDiscount }
                .sorted { $0.discountPercentage > $1.discountPercentage }
                .prefix(12)
                .map { $0 }
            topRatedProducts = catalog.products
                .sorted { $0.rating > $1.rating }
                .prefix(12)
                .map { $0 }
            recentProducts = recent.products
            recentSkip = recent.products.count
            hasMoreRecent = recentSkip < recent.total
        } catch {
            loadError = error
        }
        isLoading = false
    }

    func loadMoreRecentIfNeeded() async {
        guard !isLoadingMore, hasMoreRecent else { return }
        isLoadingMore = true
        do {
            let response = try await productService.fetchProducts(limit: pageSize, skip: recentSkip)
            recentProducts.append(contentsOf: response.products)
            recentSkip += response.products.count
            hasMoreRecent = recentSkip < response.total && !response.products.isEmpty
        } catch {
            hasMoreRecent = false
        }
        isLoadingMore = false
    }
}
