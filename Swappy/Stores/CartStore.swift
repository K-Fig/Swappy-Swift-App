import Foundation

@Observable
@MainActor
final class CartStore {
    private(set) var items: [CartItem] = []
    private(set) var isSeeding = false

    private let cartService: CartServiceProtocol
    private let productService: ProductServiceProtocol

    init(
        cartService: CartServiceProtocol = CartService(),
        productService: ProductServiceProtocol = ProductService()
    ) {
        self.cartService = cartService
        self.productService = productService
    }

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }

    var subtotal: Double {
        items.reduce(0) { $0 + $1.lineTotal }
    }

    var discount: Double {
        subtotal - discountedTotal
    }

    var discountedTotal: Double {
        items.reduce(0) { $0 + $1.discountedLineTotal }
    }

    func add(_ product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
    }

    func remove(productId: Int) {
        items.removeAll { $0.id == productId }
    }

    func setQuantity(productId: Int, quantity: Int) {
        guard let index = items.firstIndex(where: { $0.id == productId }) else { return }
        if quantity <= 0 {
            items.remove(at: index)
        } else {
            items[index].quantity = quantity
        }
    }

    func clear() {
        items.removeAll()
    }

    func seedFromRemoteCart(userId: Int) async {
        guard items.isEmpty, !isSeeding else { return }
        isSeeding = true
        defer { isSeeding = false }
        guard let cart = try? await cartService.fetchCart(userId: userId) else { return }
        let productService = productService
        let fetched: [CartItem] = await withTaskGroup(of: CartItem?.self) { group in
            for cartProduct in cart.products {
                group.addTask {
                    guard let product = try? await productService.fetchProduct(id: cartProduct.id) else { return nil }
                    return CartItem(product: product, quantity: cartProduct.quantity)
                }
            }
            var results: [CartItem] = []
            for await item in group {
                if let item { results.append(item) }
            }
            return results
        }
        items = fetched.sorted { $0.id < $1.id }
    }
}
