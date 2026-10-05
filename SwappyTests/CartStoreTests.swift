import Testing
@testable import Swappy

@MainActor
struct CartStoreTests {
    @Test func addingSameProductIncreasesQuantity() {
        let store = CartStore()
        let product = MockData.products[0]
        store.add(product)
        store.add(product)
        #expect(store.items.count == 1)
        #expect(store.itemCount == 2)
    }

    @Test func removeDeletesItem() {
        let store = CartStore()
        let product = MockData.products[0]
        store.add(product)
        store.remove(productId: product.id)
        #expect(store.items.isEmpty)
    }

    @Test func setQuantityToZeroRemovesItem() {
        let store = CartStore()
        let product = MockData.products[0]
        store.add(product, quantity: 3)
        store.setQuantity(productId: product.id, quantity: 0)
        #expect(store.items.isEmpty)
    }

    @Test func totalsReflectDiscount() {
        let store = CartStore()
        let product = MockData.products[1] // iPhone 9: price 549, discount 12.96%
        store.add(product, quantity: 2)
        #expect(store.subtotal == product.price * 2)
        #expect(store.discountedTotal < store.subtotal)
        #expect(store.discount > 0)
    }

    @Test func clearEmptiesCart() {
        let store = CartStore()
        store.add(MockData.products[0])
        store.add(MockData.products[1])
        store.clear()
        #expect(store.items.isEmpty)
        #expect(store.itemCount == 0)
    }
}
