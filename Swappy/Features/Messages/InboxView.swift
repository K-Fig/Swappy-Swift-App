import SwiftUI

struct InboxView: View {
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute

    var body: some View {
        ScrollView {
            if messages.conversations.isEmpty {
                EmptyStateView(icon: "bubble.left.and.bubble.right", title: "No messages yet", message: "Start a conversation from any listing to see it here.")
                    .padding(.top, 60)
            } else {
                VStack(spacing: SWSpacing.md) {
                    ForEach(messages.conversations) { conversation in
                        ConversationRow(conversation: conversation) {
                            openRoute(.chat(conversation.id))
                        }
                        SWDivider()
                    }
                }
                .padding(SWSpacing.md)
            }
        }
        .background(Color.swBackground)
        .navigationTitle("Inbox")
    }
}

#Preview {
    NavigationStack {
        InboxView()
            .withAppRouting()
    }
    .environment(MessagesStore())
}
