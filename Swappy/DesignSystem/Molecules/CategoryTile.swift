import SwiftUI

struct CategoryTile: View {
    let category: ProductCategory
    var action: () -> Void

    private static let gradients: [LinearGradient] = [.swSunset, .swOcean, .swFresh, .swCandy]

    private var gradient: LinearGradient {
        let index = abs(category.slug.hashValue) % Self.gradients.count
        return Self.gradients[index]
    }

    var body: some View {
        Button(action: action) {
            VStack(spacing: SWSpacing.xs) {
                ZStack {
                    Circle()
                        .fill(gradient)
                        .frame(width: 56, height: 56)
                    Image(systemName: category.icon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(Color.swTextInverse)
                }
                Text(category.name)
                    .font(.swCaption)
                    .foregroundStyle(Color.swTextPrimary)
                    .lineLimit(1)
            }
            .frame(width: 72)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: SWSpacing.md) {
            ForEach(MockData.categories) { category in
                CategoryTile(category: category) {}
            }
        }
        .padding()
    }
    .background(Color.swBackground)
}
