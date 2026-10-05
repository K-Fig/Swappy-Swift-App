import Foundation

struct Review: Codable, Hashable, Identifiable {
    let rating: Int
    let comment: String
    let date: String
    let reviewerName: String
    let reviewerEmail: String

    var id: String { reviewerEmail + date + comment }
}

struct ProductDimensions: Codable, Hashable {
    let width: Double
    let height: Double
    let depth: Double
}

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let dimensions: ProductDimensions?
    let warrantyInformation: String
    let shippingInformation: String
    let availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String

    var discountedPrice: Double {
        price * (1 - discountPercentage / 100)
    }

    var hasDiscount: Bool {
        discountPercentage > 0.5
    }

    var thumbnailURL: URL? {
        URL(string: thumbnail)
    }

    var imageURLs: [URL] {
        images.compactMap(URL.init(string:))
    }

    var isInStock: Bool {
        stock > 0
    }
}
