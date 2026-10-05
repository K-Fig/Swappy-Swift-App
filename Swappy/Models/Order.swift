import Foundation

enum OrderStatus: String, Codable, CaseIterable, Hashable {
    case processing
    case shipped
    case outForDelivery
    case delivered
    case cancelled

    var label: String {
        switch self {
        case .processing: "Processing"
        case .shipped: "Shipped"
        case .outForDelivery: "Out for delivery"
        case .delivered: "Delivered"
        case .cancelled: "Cancelled"
        }
    }

    var tone: SWStatusTone {
        switch self {
        case .processing: .info
        case .shipped: .shipped
        case .outForDelivery: .progress
        case .delivered: .success
        case .cancelled: .neutral
        }
    }
}

struct OrderItem: Identifiable, Hashable {
    let productId: Int
    let title: String
    let thumbnail: String
    let price: Double
    let quantity: Int

    var id: Int { productId }
    var thumbnailURL: URL? { URL(string: thumbnail) }
    var lineTotal: Double { price * Double(quantity) }
}

struct Order: Identifiable, Hashable {
    let id: Int
    let items: [OrderItem]
    var status: OrderStatus
    let placedDate: Date
    let total: Double
    let discountedTotal: Double
    let sellerIds: [Int]

    var itemCount: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
}
