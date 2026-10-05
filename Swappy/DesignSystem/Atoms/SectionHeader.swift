import SwiftUI

struct SectionHeader: View {
    let title: String
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        HStack {
            Text(title)
                .font(.swTitle)
                .foregroundStyle(Color.swTextPrimary)
            Spacer()
            if let actionTitle, let action {
                Button(action: action) {
                    Text(actionTitle)
                        .font(.swCaptionEmphasis)
                        .foregroundStyle(Color.swPrimary)
                }
            }
        }
    }
}

#Preview {
    VStack(spacing: SWSpacing.md) {
        SectionHeader(title: "Deals for you", actionTitle: "See all") {}
        SectionHeader(title: "Top rated")
    }
    .padding()
    .background(Color.swBackground)
}
