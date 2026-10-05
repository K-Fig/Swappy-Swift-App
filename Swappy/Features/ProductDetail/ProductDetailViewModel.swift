import Foundation

@Observable
@MainActor
final class ProductDetailViewModel {
    private(set) var product: Product?
    private(set) var seller: Seller?
    private(set) var moreFromSeller: [Product] = []
    private(set) var isLoading = false
    private(set) var loadError: Error?

    let productId: Int
    private let productService: ProductServiceProtocol
    private let sellerMapper: SellerMapperProtocol

    init(
        productId: Int,
        productService: ProductServiceProtocol = ProductService(),
        sellerMapper: SellerMapperProtocol = SellerMapper()
    ) {
        self.productId = productId
        self.productService = productService
        self.sellerMapper = sellerMapper
    }

    func loadIfNeeded() async {
        guard product == nil, !isLoading else { return }
        isLoading = true
        loadError = nil
        do {
            let product = try await productService.fetchProduct(id: productId)
            self.product = product
            async let sellerTask = sellerMapper.seller(forProductId: productId)
            async let listingsTask = sellerMapper.listings(forSellerId: sellerMapper.sellerId(forProductId: productId))
            let (seller, listings) = try await (sellerTask, listingsTask)
            self.seller = seller
            self.moreFromSeller = listings.filter { $0.id != productId }
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
