import Testing
import Foundation
@testable import Swappy

struct DecodingTests {
    @Test func decodesSingleProduct() throws {
        let product = try JSONDecoder().decode(Product.self, from: TestFixtures.data("product"))
        #expect(product.id == 1)
        #expect(product.title == "Essence Mascara Lash Princess")
        #expect(product.category == "beauty")
        #expect(product.reviews.count == 3)
        #expect(product.images.isEmpty == false)
        #expect(product.thumbnailURL != nil)
    }

    @Test func decodesProductListResponse() throws {
        let response = try JSONDecoder().decode(ProductListResponse.self, from: TestFixtures.data("products_list"))
        #expect(response.products.count == 2)
        #expect(response.limit == 2)
        #expect(response.skip == 0)
        #expect(response.total > response.products.count)
    }

    @Test func decodesCart() throws {
        let response = try JSONDecoder().decode(CartListResponse.self, from: TestFixtures.data("cart"))
        let cart = try #require(response.carts.first)
        #expect(cart.id == 1)
        #expect(cart.products.isEmpty == false)
        #expect(cart.totalQuantity == cart.products.reduce(0) { $0 + $1.quantity })
    }

    @Test func discountedPriceIsLowerThanPrice() throws {
        let product = try JSONDecoder().decode(Product.self, from: TestFixtures.data("product"))
        #expect(product.discountedPrice < product.price)
        #expect(product.hasDiscount)
    }
}
