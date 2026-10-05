import SwiftUI

struct ConversationRow: View {
    let conversation: Conversation
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: SWSpacing.sm) {
                AvatarView(url: conversation.sellerAvatarURL, initials: initials, size: 52)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(conversation.sellerName)
                            .font(.swBodyEmphasis)
                            .foregroundStyle(Color.swTextPrimary)
                        Spacer()
                        if let date = conversation.lastMessage?.date {
                            Text(date, style: .time)
                                .font(.swCaption)
                                .foregroundStyle(Color.swTextSecondary)
                        }
                    }
                    Text(conversation.lastMessage?.text ?? "Say hello")
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                        .lineLimit(1)
                }

                if conversation.hasUnread {
                    Circle()
                        .fill(Color.swPrimary)
                        .frame(width: 8, height: 8)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    private var initials: String {
        let parts = conversation.sellerName.split(separator: " ")
        return parts.prefix(2).compactMap { $0.first.map(String.init) }.joined().uppercased()
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        ForEach(MockData.conversations) { conversation in
            ConversationRow(conversation: conversation) {}
        }
    }
    .padding()
    .background(Color.swBackground)
}
