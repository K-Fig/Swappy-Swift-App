import Foundation

protocol SellerMapperProtocol: Sendable {
    func sellerId(forProductId productId: Int) -> Int
    func seller(forProductId productId: Int) async throws -> Seller
    func seller(forSellerId sellerId: Int) async throws -> Seller
    func listings(forSellerId sellerId: Int) async throws -> [Product]
}

actor SellerMapper: SellerMapperProtocol {
    private let productService: ProductServiceProtocol
    private let userService: UserServiceProtocol
    private var catalogBySeller: [Int: [Product]]?

    init(
        productService: ProductServiceProtocol = ProductService(),
        userService: UserServiceProtocol = UserService()
    ) {
        self.productService = productService
        self.userService = userService
    }

    nonisolated func sellerId(forProductId productId: Int) -> Int {
        (productId % 30) + 2
    }

    func listings(forSellerId sellerId: Int) async throws -> [Product] {
        let grouped = try await catalogGroupedBySeller()
        return grouped[sellerId] ?? []
    }

    func seller(forProductId productId: Int) async throws -> Seller {
        try await seller(forSellerId: sellerId(forProductId: productId))
    }

    func seller(forSellerId sellerId: Int) async throws -> Seller {
        async let userTask = userService.fetchUser(id: sellerId)
        let listings = try await listings(forSellerId: sellerId)
        let user = try await userTask
        let averageRating = listings.isEmpty
            ? 0
            : listings.reduce(0) { $0 + $1.rating } / Double(listings.count)
        return Seller(
            id: user.id,
            name: user.fullName,
            avatarURL: user.imageURL,
            initials: user.initials,
            city: user.address.city,
            country: user.address.country,
            rating: averageRating,
            listingsCount: listings.count
        )
    }

    private func catalogGroupedBySeller() async throws -> [Int: [Product]] {
        if let catalogBySeller { return catalogBySeller }
        let response = try await productService.fetchProducts(limit: 0, skip: 0)
        let grouped = Dictionary(grouping: response.products) { sellerId(forProductId: $0.id) }
        catalogBySeller = grouped
        return grouped
    }
}
