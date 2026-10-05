import SwiftUI

struct FAQDetailView: View {
    let faq: FAQ

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpacing.md) {
                SWBadge(text: faq.category.rawValue, style: .neutral)
                Text(faq.question)
                    .font(.swTitle)
                    .foregroundStyle(Color.swTextPrimary)
                Text(faq.answer)
                    .font(.swBody)
                    .foregroundStyle(Color.swTextSecondary)
            }
            .padding(SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        FAQDetailView(faq: MockData.faqs[0])
    }
}
