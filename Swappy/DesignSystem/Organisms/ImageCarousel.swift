import SwiftUI

struct ImageCarousel: View {
    let urls: [URL]
    @State private var selection = 0

    var body: some View {
        TabView(selection: $selection) {
            ForEach(Array(urls.enumerated()), id: \.offset) { index, url in
                RemoteImage(url: url, cornerRadius: 0, contentMode: .fit)
                    .tag(index)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: urls.count > 1 ? .always : .never))
        .frame(height: 320)
    }
}

#Preview {
    ImageCarousel(urls: MockData.products[0].imageURLs)
        .background(Color.swBackground)
}
