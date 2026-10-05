import Foundation

@Observable
@MainActor
final class MessagesStore {
    private(set) var conversations: [Conversation] = []

    private static let autoReplies = [
        "Thanks for reaching out! I'll get back to you shortly.",
        "Hey! Yes, that's still available.",
        "Sure, I can ship that out tomorrow.",
        "Great question — let me check and reply soon.",
        "Appreciate your patience, I'll sort this out for you.",
    ]

    func conversation(id: UUID) -> Conversation? {
        conversations.first { $0.id == id }
    }

    @discardableResult
    func startConversation(
        sellerId: Int,
        sellerName: String,
        sellerAvatarURL: URL?,
        productContext: Conversation.ProductContext? = nil,
        orderContext: Conversation.OrderContext? = nil
    ) -> Conversation {
        if let index = conversations.firstIndex(where: { $0.sellerId == sellerId }) {
            if let productContext {
                conversations[index].productContext = productContext
            }
            if let orderContext {
                conversations[index].orderContext = orderContext
            }
            return conversations[index]
        }
        let conversation = Conversation(
            sellerId: sellerId,
            sellerName: sellerName,
            sellerAvatarURL: sellerAvatarURL,
            productContext: productContext,
            orderContext: orderContext
        )
        conversations.insert(conversation, at: 0)
        return conversation
    }

    func sendMessage(_ text: String, in conversationId: UUID) {
        guard let index = conversations.firstIndex(where: { $0.id == conversationId }) else { return }
        conversations[index].messages.append(Message(text: text, isFromUser: true))

        Task {
            try? await Task.sleep(for: .seconds(1.2))
            guard let current = conversations.firstIndex(where: { $0.id == conversationId }) else { return }
            let reply = Self.autoReplies.randomElement() ?? Self.autoReplies[0]
            conversations[current].messages.append(Message(text: reply, isFromUser: false))
        }
    }
}
