import Foundation

struct CartItem: Identifiable, Hashable {
    var id: Int { product.id }
    var product: Product
    var quantity: Int

    var lineTotal: Double {
        product.price * Double(quantity)
    }

    var discountedLineTotal: Double {
        product.discountedPrice * Double(quantity)
    }
}
