import SwiftUI

struct ChatView: View {
    let conversationId: UUID
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute
    @State private var draft = ""

    private var conversation: Conversation? {
        messages.conversation(id: conversationId)
    }

    var body: some View {
        VStack(spacing: 0) {
            if let context = conversation?.productContext {
                Button {
                    openRoute(.product(context.productId))
                } label: {
                    HStack(spacing: SWSpacing.sm) {
                        RemoteImage(url: context.thumbnailURL, cornerRadius: SWRadius.sm)
                            .frame(width: 40, height: 40)
                        Text(context.productTitle)
                            .font(.swCaption)
                            .foregroundStyle(Color.swTextPrimary)
                            .lineLimit(1)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption2)
                            .foregroundStyle(Color.swTextSecondary)
                    }
                    .padding(SWSpacing.sm)
                    .background(Color.swSurfaceAlt)
                }
                .buttonStyle(.plain)
            } else if let context = conversation?.orderContext {
                HStack {
                    Image(systemName: "shippingbox.fill")
                        .foregroundStyle(Color.swTextSecondary)
                    Text(context.reason)
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextPrimary)
                    Spacer()
                }
                .padding(SWSpacing.sm)
                .background(Color.swSurfaceAlt)
            }

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: SWSpacing.sm) {
                        ForEach(conversation?.messages ?? []) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding(SWSpacing.md)
                }
                .onChange(of: conversation?.messages.count) {
                    if let lastId = conversation?.messages.last?.id {
                        withAnimation {
                            proxy.scrollTo(lastId, anchor: .bottom)
                        }
                    }
                }
            }

            ChatInputBar(text: $draft) {
                guard !draft.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                messages.sendMessage(draft, in: conversationId)
                draft = ""
            }
        }
        .background(Color.swBackground)
        .navigationTitle(conversation?.sellerName ?? "Chat")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        ChatView(conversationId: MockData.conversations[0].id)
            .withAppRouting()
    }
    .environment(MessagesStore())
}
