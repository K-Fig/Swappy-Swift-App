import Foundation

enum MockData {
    static let categories: [ProductCategory] = [
        ProductCategory(slug: "smartphones", name: "Smartphones", url: "https://dummyjson.com/products/category/smartphones"),
        ProductCategory(slug: "laptops", name: "Laptops", url: "https://dummyjson.com/products/category/laptops"),
        ProductCategory(slug: "fragrances", name: "Fragrances", url: "https://dummyjson.com/products/category/fragrances"),
        ProductCategory(slug: "skincare", name: "Skincare", url: "https://dummyjson.com/products/category/skincare"),
        ProductCategory(slug: "womens-dresses", name: "Women's Dresses", url: "https://dummyjson.com/products/category/womens-dresses"),
        ProductCategory(slug: "mens-shoes", name: "Men's Shoes", url: "https://dummyjson.com/products/category/mens-shoes"),
        ProductCategory(slug: "furniture", name: "Furniture", url: "https://dummyjson.com/products/category/furniture"),
        ProductCategory(slug: "sunglasses", name: "Sunglasses", url: "https://dummyjson.com/products/category/sunglasses"),
    ]

    static let reviews: [Review] = [
        Review(rating: 5, comment: "Exactly as described, fast shipping!", date: "2026-08-14T09:41:02.053Z", reviewerName: "Jordan Lee", reviewerEmail: "jordan.lee@x.dummyjson.com"),
        Review(rating: 4, comment: "Good quality for the price.", date: "2026-08-02T09:41:02.053Z", reviewerName: "Priya Natarajan", reviewerEmail: "priya.n@x.dummyjson.com"),
        Review(rating: 3, comment: "Would not recommend.", date: "2026-07-20T09:41:02.053Z", reviewerName: "Sam Okafor", reviewerEmail: "sam.okafor@x.dummyjson.com"),
    ]

    static let products: [Product] = [
        Product(id: 1, title: "Essence Mascara Lash Princess", description: "Volumizing and lengthening mascara with a cruelty-free formula.", category: "beauty", price: 9.99, discountPercentage: 10.48, rating: 2.56, stock: 99, tags: ["beauty", "mascara"], brand: "Essence", sku: "BEA-001", dimensions: ProductDimensions(width: 15.1, height: 13.1, depth: 23.0), warrantyInformation: "1 week warranty", shippingInformation: "Ships in 3-5 business days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "No return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/beauty/essence-mascara-lash-princess/thumbnail.webp"),
        Product(id: 2, title: "iPhone 9", description: "An apple mobile which is nothing like apple.", category: "smartphones", price: 549, discountPercentage: 12.96, rating: 4.69, stock: 34, tags: ["smartphones"], brand: "Apple", sku: "PHN-002", dimensions: ProductDimensions(width: 7.5, height: 15.0, depth: 0.8), warrantyInformation: "1 year warranty", shippingInformation: "Ships overnight", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "30 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/smartphones/iphone-9/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/smartphones/iphone-9/thumbnail.webp"),
        Product(id: 3, title: "MacBook Pro", description: "A thin and light laptop with the powerful M2 chip.", category: "laptops", price: 1749, discountPercentage: 7.17, rating: 4.57, stock: 12, tags: ["laptops"], brand: "Apple", sku: "LAP-003", dimensions: ProductDimensions(width: 30.4, height: 1.6, depth: 21.2), warrantyInformation: "1 year warranty", shippingInformation: "Ships in 1 week", availabilityStatus: "Low Stock", reviews: reviews, returnPolicy: "30 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/laptops/macbook-pro/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/laptops/macbook-pro/thumbnail.webp"),
        Product(id: 4, title: "Calvin Klein CK One", description: "A classic unisex fragrance with citrus notes.", category: "fragrances", price: 35.99, discountPercentage: 18.94, rating: 4.37, stock: 55, tags: ["fragrances"], brand: "Calvin Klein", sku: "FRG-004", dimensions: ProductDimensions(width: 5.0, height: 12.0, depth: 5.0), warrantyInformation: "No warranty", shippingInformation: "Ships in 2-3 days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "No return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/fragrances/calvin-klein-ck-one/thumbnail.webp"),
        Product(id: 5, title: "Hyaluronic Acid Serum", description: "Deeply hydrating serum for all skin types.", category: "skincare", price: 19.99, discountPercentage: 11.4, rating: 4.72, stock: 80, tags: ["skincare"], brand: "Glow Lab", sku: "SKN-005", dimensions: ProductDimensions(width: 4.0, height: 10.0, depth: 4.0), warrantyInformation: "No warranty", shippingInformation: "Ships in 3-5 business days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "7 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/skincare/hyaluronic-acid-serum/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/skincare/hyaluronic-acid-serum/thumbnail.webp"),
        Product(id: 6, title: "Puffer Jacket", description: "Warm and lightweight winter puffer jacket.", category: "womens-dresses", price: 139, discountPercentage: 9.6, rating: 4.1, stock: 20, tags: ["womens-dresses"], brand: "Nordic Wear", sku: "APP-006", dimensions: ProductDimensions(width: 40.0, height: 70.0, depth: 10.0), warrantyInformation: "No warranty", shippingInformation: "Ships in 3-5 business days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "30 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/womens-dresses/puffer-jacket/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/womens-dresses/puffer-jacket/thumbnail.webp"),
        Product(id: 7, title: "Classic Leather Sneakers", description: "Everyday sneakers with premium leather uppers.", category: "mens-shoes", price: 89.99, discountPercentage: 5.2, rating: 4.4, stock: 64, tags: ["mens-shoes"], brand: "Urban Stride", sku: "SHO-007", dimensions: ProductDimensions(width: 30.0, height: 12.0, depth: 10.0), warrantyInformation: "90 days warranty", shippingInformation: "Ships in 3-5 business days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "30 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/mens-shoes/classic-leather-sneakers/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/mens-shoes/classic-leather-sneakers/thumbnail.webp"),
        Product(id: 8, title: "Mid-Century Accent Chair", description: "A stylish accent chair for your living room.", category: "furniture", price: 299, discountPercentage: 14.1, rating: 4.3, stock: 8, tags: ["furniture"], brand: "HomeCraft", sku: "FUR-008", dimensions: ProductDimensions(width: 70.0, height: 85.0, depth: 75.0), warrantyInformation: "1 year warranty", shippingInformation: "Ships in 1-2 weeks", availabilityStatus: "Low Stock", reviews: reviews, returnPolicy: "No return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/furniture/mid-century-accent-chair/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/furniture/mid-century-accent-chair/thumbnail.webp"),
        Product(id: 9, title: "Retro Round Sunglasses", description: "UV-protective sunglasses with a vintage look.", category: "sunglasses", price: 29.99, discountPercentage: 20.3, rating: 3.9, stock: 150, tags: ["sunglasses"], brand: "Sunbeam", sku: "SUN-009", dimensions: ProductDimensions(width: 14.0, height: 5.0, depth: 5.0), warrantyInformation: "No warranty", shippingInformation: "Ships in 3-5 business days", availabilityStatus: "In Stock", reviews: reviews, returnPolicy: "7 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/sunglasses/retro-round-sunglasses/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/sunglasses/retro-round-sunglasses/thumbnail.webp"),
        Product(id: 10, title: "Samsung Galaxy Book", description: "Slim and powerful Windows ultrabook.", category: "laptops", price: 1099, discountPercentage: 8.4, rating: 4.25, stock: 0, tags: ["laptops"], brand: "Samsung", sku: "LAP-010", dimensions: ProductDimensions(width: 31.0, height: 1.5, depth: 22.0), warrantyInformation: "1 year warranty", shippingInformation: "Ships in 1 week", availabilityStatus: "Out of Stock", reviews: reviews, returnPolicy: "30 days return policy", minimumOrderQuantity: 1, images: ["https://cdn.dummyjson.com/product-images/laptops/samsung-galaxy-book/1.webp"], thumbnail: "https://cdn.dummyjson.com/product-images/laptops/samsung-galaxy-book/thumbnail.webp"),
    ]

    static let sessionUser = User(
        id: 1,
        firstName: "Emily",
        lastName: "Johnson",
        email: "emily.johnson@x.dummyjson.com",
        phone: "+1 965-431-3024",
        username: "emilys",
        image: "https://dummyjson.com/icon/emilys/128",
        address: User.Address(address: "626 Main Street", city: "Phoenix", state: "Mississippi", postalCode: "29112", country: "United States")
    )

    static let sellerUser = User(
        id: 7,
        firstName: "Marcus",
        lastName: "Reed",
        email: "marcus.reed@x.dummyjson.com",
        phone: "+1 555-201-8844",
        username: "marcusr",
        image: "https://dummyjson.com/icon/marcusr/128",
        address: User.Address(address: "88 Baker Street", city: "Austin", state: "Texas", postalCode: "73301", country: "United States")
    )

    static let seller = Seller(
        id: 7,
        name: "Marcus Reed",
        avatarURL: URL(string: "https://dummyjson.com/icon/marcusr/128"),
        initials: "MR",
        city: "Austin",
        country: "United States",
        rating: 4.6,
        listingsCount: 18
    )

    static let cartItems: [CartItem] = [
        CartItem(product: products[1], quantity: 1),
        CartItem(product: products[4], quantity: 2),
        CartItem(product: products[8], quantity: 1),
    ]

    static let cartDTO = CartDTO(
        id: 1,
        products: [
            CartProductDTO(id: 2, title: "iPhone 9", price: 549, quantity: 1, total: 549, discountPercentage: 12.96, discountedTotal: 478, thumbnail: products[1].thumbnail),
            CartProductDTO(id: 5, title: "Hyaluronic Acid Serum", price: 19.99, quantity: 2, total: 39.98, discountPercentage: 11.4, discountedTotal: 35.42, thumbnail: products[4].thumbnail),
        ],
        total: 588.98,
        discountedTotal: 513.42,
        userId: 1,
        totalProducts: 2,
        totalQuantity: 3
    )

    static let orders: [Order] = {
        let mapper = OrderMapper(sellerMapper: PreviewSellerMapper(), referenceDate: Date())
        let carts = [
            cartDTO,
            CartDTO(id: 2, products: [cartDTO.products[0]], total: 549, discountedTotal: 478, userId: 1, totalProducts: 1, totalQuantity: 1),
            CartDTO(id: 3, products: cartDTO.products, total: 588.98, discountedTotal: 513.42, userId: 1, totalProducts: 2, totalQuantity: 3),
        ]
        return mapper.makeOrders(from: carts)
    }()

    static let conversations: [Conversation] = [
        Conversation(
            sellerId: 7,
            sellerName: "Marcus Reed",
            sellerAvatarURL: URL(string: "https://dummyjson.com/icon/marcusr/128"),
            productContext: Conversation.ProductContext(productId: 2, productTitle: "iPhone 9", productThumbnail: products[1].thumbnail),
            messages: [
                Message(text: "Hi! Is the iPhone 9 still available?", isFromUser: true, date: Date().addingTimeInterval(-3600)),
                Message(text: "Yes, it is! Ready to ship today.", isFromUser: false, date: Date().addingTimeInterval(-3500)),
            ]
        ),
        Conversation(
            sellerId: 12,
            sellerName: "Avery Chen",
            sellerAvatarURL: URL(string: "https://dummyjson.com/icon/averyc/128"),
            messages: [
                Message(text: "Thanks for your purchase!", isFromUser: false, date: Date().addingTimeInterval(-86_400)),
            ]
        ),
    ]

    static let faqs: [FAQ] = [
        FAQ(id: 1, category: .buying, question: "How do I make an offer on an item?", answer: "Tap \"Message seller\" on any listing to start a conversation and negotiate the price directly."),
        FAQ(id: 2, category: .ordersShipping, question: "How do I track my order?", answer: "Open My Orders from your profile and tap any order to see its live status timeline."),
        FAQ(id: 3, category: .returns, question: "What is the return window?", answer: "Most items can be returned within 30 days of delivery unless noted otherwise on the listing."),
        FAQ(id: 4, category: .payments, question: "What payment methods are supported?", answer: "Swappy supports all major credit and debit cards at checkout."),
        FAQ(id: 5, category: .account, question: "How do I update my shipping address?", answer: "Go to Profile > Account Info to update your saved address."),
    ]
}

private struct PreviewSellerMapper: SellerMapperProtocol {
    func sellerId(forProductId productId: Int) -> Int { (productId % 30) + 2 }
    func seller(forProductId productId: Int) async throws -> Seller { MockData.seller }
    func seller(forSellerId sellerId: Int) async throws -> Seller { MockData.seller }
    func listings(forSellerId sellerId: Int) async throws -> [Product] { MockData.products }
}
