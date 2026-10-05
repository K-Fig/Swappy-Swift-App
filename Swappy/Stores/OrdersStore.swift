import Foundation

@Observable
@MainActor
final class OrdersStore {
    private(set) var orders: [Order] = []
    private(set) var isLoading = false

    private let cartService: CartServiceProtocol
    private let orderMapper: OrderMapperProtocol
    private let sellerMapper: SellerMapperProtocol
    private var nextLocalOrderId = 90_000

    init(
        cartService: CartServiceProtocol = CartService(),
        orderMapper: OrderMapperProtocol = OrderMapper(),
        sellerMapper: SellerMapperProtocol = SellerMapper()
    ) {
        self.cartService = cartService
        self.orderMapper = orderMapper
        self.sellerMapper = sellerMapper
    }

    func loadOrdersIfNeeded(userId: Int) async {
        guard orders.isEmpty, !isLoading else { return }
        isLoading = true
        defer { isLoading = false }
        var carts: [CartDTO] = []
        if let userCart = try? await cartService.fetchCart(userId: userId) {
            carts.append(userCart)
        }
        if let extra = try? await cartService.fetchExtraCarts(limit: 6) {
            carts.append(contentsOf: extra.filter { $0.userId != userId })
        }
        orders = orderMapper.makeOrders(from: carts)
    }

    func order(id: Int) -> Order? {
        orders.first { $0.id == id }
    }

    func placeOrder(from items: [CartItem]) -> Order {
        let orderItems = items.map {
            OrderItem(productId: $0.product.id, title: $0.product.title, thumbnail: $0.product.thumbnail, price: $0.product.price, quantity: $0.quantity)
        }
        let sellerIds = Set(items.map { sellerMapper.sellerId(forProductId: $0.product.id) })
        let subtotal = items.reduce(0) { $0 + $1.lineTotal }
        let discountedTotal = items.reduce(0) { $0 + $1.discountedLineTotal }
        let order = Order(
            id: nextLocalOrderId,
            items: orderItems,
            status: .processing,
            placedDate: Date(),
            total: subtotal,
            discountedTotal: discountedTotal,
            sellerIds: Array(sellerIds).sorted()
        )
        nextLocalOrderId += 1
        orders.insert(order, at: 0)
        return order
    }

    func updateStatus(orderId: Int, status: OrderStatus) {
        guard let index = orders.firstIndex(where: { $0.id == orderId }) else { return }
        orders[index].status = status
    }
}
