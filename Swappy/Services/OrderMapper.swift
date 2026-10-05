import Foundation

protocol OrderMapperProtocol: Sendable {
    func makeOrder(from cart: CartDTO) -> Order
    func makeOrders(from carts: [CartDTO]) -> [Order]
}

struct OrderMapper: OrderMapperProtocol {
    private let sellerMapper: SellerMapperProtocol
    private let referenceDate: Date

    init(sellerMapper: SellerMapperProtocol = SellerMapper(), referenceDate: Date = Date()) {
        self.sellerMapper = sellerMapper
        self.referenceDate = referenceDate
    }

    func makeOrder(from cart: CartDTO) -> Order {
        let items = cart.products.map {
            OrderItem(productId: $0.id, title: $0.title, thumbnail: $0.thumbnail, price: $0.price, quantity: $0.quantity)
        }
        let sellerIds = Set(cart.products.map { sellerMapper.sellerId(forProductId: $0.id) })
        return Order(
            id: cart.id,
            items: items,
            status: Self.status(forCartId: cart.id),
            placedDate: Self.placedDate(forCartId: cart.id, referenceDate: referenceDate),
            total: cart.total,
            discountedTotal: cart.discountedTotal,
            sellerIds: Array(sellerIds).sorted()
        )
    }

    func makeOrders(from carts: [CartDTO]) -> [Order] {
        carts.map(makeOrder).sorted { $0.placedDate > $1.placedDate }
    }

    static func status(forCartId cartId: Int) -> OrderStatus {
        let cycle = OrderStatus.allCases
        return cycle[cartId % cycle.count]
    }

    static func placedDate(forCartId cartId: Int, referenceDate: Date) -> Date {
        let daysAgo = (cartId * 3) % 60 + 1
        return Calendar.current.date(byAdding: .day, value: -daysAgo, to: referenceDate) ?? referenceDate
    }
}
