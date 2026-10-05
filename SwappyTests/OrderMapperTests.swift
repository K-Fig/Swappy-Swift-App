import Testing
import Foundation
@testable import Swappy

private struct StubSellerMapper: SellerMapperProtocol {
    func sellerId(forProductId productId: Int) -> Int { (productId % 30) + 2 }
    func seller(forProductId productId: Int) async throws -> Seller { MockData.seller }
    func seller(forSellerId sellerId: Int) async throws -> Seller { MockData.seller }
    func listings(forSellerId sellerId: Int) async throws -> [Product] { [] }
}

struct OrderMapperTests {
    @Test func statusCyclesDeterministicallyByCartId() {
        let statuses = OrderStatus.allCases
        for cartId in 0..<20 {
            #expect(OrderMapper.status(forCartId: cartId) == statuses[cartId % statuses.count])
        }
    }

    @Test func sameCartIdAlwaysProducesSameStatus() {
        #expect(OrderMapper.status(forCartId: 7) == OrderMapper.status(forCartId: 7))
    }

    @Test func placedDateIsBeforeReferenceDate() {
        let reference = Date()
        let date = OrderMapper.placedDate(forCartId: 5, referenceDate: reference)
        #expect(date < reference)
    }

    @Test func makeOrderMapsFieldsFromCart() {
        let mapper = OrderMapper(sellerMapper: StubSellerMapper(), referenceDate: Date())
        let order = mapper.makeOrder(from: MockData.cartDTO)
        #expect(order.id == MockData.cartDTO.id)
        #expect(order.items.count == MockData.cartDTO.products.count)
        #expect(order.total == MockData.cartDTO.total)
        #expect(order.discountedTotal == MockData.cartDTO.discountedTotal)
        #expect(order.itemCount == MockData.cartDTO.products.reduce(0) { $0 + $1.quantity })
    }

    @Test func makeOrdersSortsNewestFirst() {
        let mapper = OrderMapper(sellerMapper: StubSellerMapper(), referenceDate: Date())
        let carts = [
            MockData.cartDTO,
            CartDTO(id: 40, products: MockData.cartDTO.products, total: 10, discountedTotal: 9, userId: 1, totalProducts: 1, totalQuantity: 1),
        ]
        let orders = mapper.makeOrders(from: carts)
        #expect(orders.first!.placedDate >= orders.last!.placedDate)
    }
}
