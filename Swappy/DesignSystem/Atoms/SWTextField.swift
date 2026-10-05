import SwiftUI

struct SWTextField: View {
    let placeholder: String
    @Binding var text: String
    var icon: String? = nil
    var isSecure: Bool = false

    var body: some View {
        HStack(spacing: SWSpacing.xs) {
            if let icon {
                Image(systemName: icon)
                    .foregroundStyle(Color.swTextSecondary)
            }
            Group {
                if isSecure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .font(.swBody)
        }
        .padding(.horizontal, SWSpacing.sm)
        .frame(height: 48)
        .background(Color.swSurfaceAlt)
        .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
    }
}

#Preview {
    VStack(spacing: SWSpacing.sm) {
        SWTextField(placeholder: "Search Swappy", text: .constant(""), icon: "magnifyingglass")
        SWTextField(placeholder: "Email", text: .constant("jamie@example.com"))
    }
    .padding()
    .background(Color.swBackground)
}
