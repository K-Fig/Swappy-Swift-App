import SwiftUI

struct FAQRow: View {
    let faq: FAQ
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack {
                Text(faq.question)
                    .font(.swBody)
                    .foregroundStyle(Color.swTextPrimary)
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundStyle(Color.swTextSecondary)
            }
            .padding(.vertical, SWSpacing.xs)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: SWSpacing.xs) {
        ForEach(MockData.faqs) { faq in
            FAQRow(faq: faq) {}
            SWDivider()
        }
    }
    .padding()
    .background(Color.swBackground)
}
