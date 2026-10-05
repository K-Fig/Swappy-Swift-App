import Foundation

enum FAQCategory: String, CaseIterable, Identifiable, Hashable {
    case buying = "Buying"
    case ordersShipping = "Orders & Shipping"
    case returns = "Returns"
    case payments = "Payments"
    case account = "Account"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .buying: "bag.fill"
        case .ordersShipping: "shippingbox.fill"
        case .returns: "arrow.uturn.left.circle.fill"
        case .payments: "creditcard.fill"
        case .account: "person.crop.circle.fill"
        }
    }
}

struct FAQ: Identifiable, Hashable {
    let id: Int
    let category: FAQCategory
    let question: String
    let answer: String
}
