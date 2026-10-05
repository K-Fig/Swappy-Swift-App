import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    var onSend: () -> Void

    private var isEmpty: Bool {
        text.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        HStack(spacing: SWSpacing.xs) {
            SWTextField(placeholder: "Message", text: $text)
            Button(action: onSend) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(Color.swTextInverse)
                    .frame(width: 40, height: 40)
                    .background(isEmpty ? AnyShapeStyle(Color.swBorder) : AnyShapeStyle(LinearGradient.swSunset))
                    .clipShape(Circle())
            }
            .disabled(isEmpty)
            .animation(.spring(duration: 0.2), value: isEmpty)
        }
        .padding(SWSpacing.sm)
        .background(Color.swSurface)
    }
}

#Preview {
    ChatInputBar(text: .constant("Is this still available?"), onSend: {})
        .background(Color.swBackground)
}
