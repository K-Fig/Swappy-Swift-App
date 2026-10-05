import Testing
import Foundation
@testable import Swappy

private struct StubProductService: ProductServiceProtocol {
    let products: [Product]

    func fetchProducts(limit: Int, skip: Int) async throws -> ProductListResponse {
        ProductListResponse(products: products, total: products.count, skip: skip, limit: limit)
    }
    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        ProductListResponse(products: [], total: 0, skip: skip, limit: limit)
    }
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        ProductListResponse(products: [], total: 0, skip: skip, limit: limit)
    }
    func fetchCategories() async throws -> [ProductCategory] { [] }
    func fetchProduct(id: Int) async throws -> Product {
        guard let product = products.first(where: { $0.id == id }) else { throw APIError.badStatus(404) }
        return product
    }
}

private struct StubUserService: UserServiceProtocol {
    func fetchUser(id: Int) async throws -> User {
        User(
            id: id,
            firstName: "Seller",
            lastName: "#\(id)",
            email: "seller\(id)@x.dummyjson.com",
            phone: "+1 555-000-0000",
            username: "seller\(id)",
            image: "https://dummyjson.com/icon/seller\(id)/128",
            address: User.Address(address: "1 Market St", city: "Austin", state: "Texas", postalCode: "73301", country: "United States")
        )
    }
}

struct SellerMapperTests {
    @Test(arguments: [1, 2, 29, 30, 31, 59, 60])
    func sellerIdFormulaIsDeterministic(productId: Int) {
        let mapper = SellerMapper(productService: StubProductService(products: []), userService: StubUserService())
        #expect(mapper.sellerId(forProductId: productId) == (productId % 30) + 2)
    }

    @Test func listingsGroupBySellerId() async throws {
        let products = MockData.products
        let mapper = SellerMapper(productService: StubProductService(products: products), userService: StubUserService())
        let sellerId = mapper.sellerId(forProductId: products[0].id)
        let listings = try await mapper.listings(forSellerId: sellerId)
        #expect(listings.contains { $0.id == products[0].id })
        #expect(listings.allSatisfy { mapper.sellerId(forProductId: $0.id) == sellerId })
    }

    @Test func sellerRatingIsAverageOfListings() async throws {
        let productA = MockData.products[0]
        let productB = MockData.products[1]
        // Both product ids map to the same sellerId under (id % 30) + 2.
        let idA = 1
        let idB = idA + 30
        let sharedSellerId = (idA % 30) + 2
        let a = Product(id: idA, title: productA.title, description: productA.description, category: productA.category, price: productA.price, discountPercentage: productA.discountPercentage, rating: 4.0, stock: productA.stock, tags: productA.tags, brand: productA.brand, sku: productA.sku, dimensions: productA.dimensions, warrantyInformation: productA.warrantyInformation, shippingInformation: productA.shippingInformation, availabilityStatus: productA.availabilityStatus, reviews: productA.reviews, returnPolicy: productA.returnPolicy, minimumOrderQuantity: productA.minimumOrderQuantity, images: productA.images, thumbnail: productA.thumbnail)
        let b = Product(id: idB, title: productB.title, description: productB.description, category: productB.category, price: productB.price, discountPercentage: productB.discountPercentage, rating: 2.0, stock: productB.stock, tags: productB.tags, brand: productB.brand, sku: productB.sku, dimensions: productB.dimensions, warrantyInformation: productB.warrantyInformation, shippingInformation: productB.shippingInformation, availabilityStatus: productB.availabilityStatus, reviews: productB.reviews, returnPolicy: productB.returnPolicy, minimumOrderQuantity: productB.minimumOrderQuantity, images: productB.images, thumbnail: productB.thumbnail)

        let mapper = SellerMapper(productService: StubProductService(products: [a, b]), userService: StubUserService())
        let seller = try await mapper.seller(forSellerId: sharedSellerId)
        #expect(seller.listingsCount == 2)
        #expect(seller.rating == 3.0)
        #expect(seller.id == sharedSellerId)
    }
}
