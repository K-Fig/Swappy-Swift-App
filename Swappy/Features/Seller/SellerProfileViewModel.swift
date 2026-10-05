import Foundation

@Observable
@MainActor
final class SellerProfileViewModel {
    private(set) var seller: Seller?
    private(set) var listings: [Product] = []
    private(set) var isLoading = false
    private(set) var loadError: Error?

    let sellerId: Int
    private let sellerMapper: SellerMapperProtocol

    init(sellerId: Int, sellerMapper: SellerMapperProtocol = SellerMapper()) {
        self.sellerId = sellerId
        self.sellerMapper = sellerMapper
    }

    func loadIfNeeded() async {
        guard seller == nil, !isLoading else { return }
        isLoading = true
        loadError = nil
        do {
            async let sellerTask = sellerMapper.seller(forSellerId: sellerId)
            async let listingsTask = sellerMapper.listings(forSellerId: sellerId)
            let (seller, listings) = try await (sellerTask, listingsTask)
            self.seller = seller
            self.listings = listings
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
