import Foundation

struct Message: Identifiable, Hashable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let date: Date

    init(id: UUID = UUID(), text: String, isFromUser: Bool, date: Date = Date()) {
        self.id = id
        self.text = text
        self.isFromUser = isFromUser
        self.date = date
    }
}

struct Conversation: Identifiable, Hashable {
    struct ProductContext: Hashable {
        let productId: Int
        let productTitle: String
        let productThumbnail: String

        var thumbnailURL: URL? { URL(string: productThumbnail) }
    }

    struct OrderContext: Hashable {
        let orderId: Int
        let reason: String
    }

    let id: UUID
    let sellerId: Int
    var sellerName: String
    var sellerAvatarURL: URL?
    var productContext: ProductContext?
    var orderContext: OrderContext?
    var messages: [Message]

    init(
        id: UUID = UUID(),
        sellerId: Int,
        sellerName: String,
        sellerAvatarURL: URL?,
        productContext: ProductContext? = nil,
        orderContext: OrderContext? = nil,
        messages: [Message] = []
    ) {
        self.id = id
        self.sellerId = sellerId
        self.sellerName = sellerName
        self.sellerAvatarURL = sellerAvatarURL
        self.productContext = productContext
        self.orderContext = orderContext
        self.messages = messages
    }

    var lastMessage: Message? { messages.last }
    var hasUnread: Bool = false
}
