import Foundation

struct ProductListResponse: Codable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

struct CartProductDTO: Codable, Hashable {
    let id: Int
    let title: String
    let price: Double
    let quantity: Int
    let total: Double
    let discountPercentage: Double
    let discountedTotal: Double
    let thumbnail: String
}

struct CartDTO: Codable, Hashable {
    let id: Int
    let products: [CartProductDTO]
    let total: Double
    let discountedTotal: Double
    let userId: Int
    let totalProducts: Int
    let totalQuantity: Int
}

struct CartListResponse: Codable {
    let carts: [CartDTO]
    let total: Int
    let skip: Int
    let limit: Int
}
