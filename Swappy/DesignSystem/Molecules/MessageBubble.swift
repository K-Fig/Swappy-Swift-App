import SwiftUI

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isFromUser { Spacer(minLength: 40) }

            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                Text(message.text)
                    .font(.swBody)
                    .foregroundStyle(message.isFromUser ? Color.swTextInverse : Color.swTextPrimary)
                    .padding(.horizontal, SWSpacing.sm)
                    .padding(.vertical, SWSpacing.xs)
                    .background {
                        if message.isFromUser {
                            LinearGradient.swSunset
                        } else {
                            Color.swSurfaceAlt
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))

                Text(message.date, style: .time)
                    .font(.swCaption)
                    .foregroundStyle(Color.swTextSecondary)
            }

            if !message.isFromUser { Spacer(minLength: 40) }
        }
    }
}

#Preview {
    VStack(spacing: SWSpacing.sm) {
        MessageBubble(message: Message(text: "Hi! Is this still available?", isFromUser: true))
        MessageBubble(message: Message(text: "Yes, it is! Ready to ship today.", isFromUser: false))
    }
    .padding()
    .background(Color.swBackground)
}
