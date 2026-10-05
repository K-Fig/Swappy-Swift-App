import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String = "Search Swappy"
    var onSubmit: () -> Void = {}

    var body: some View {
        SWTextField(placeholder: placeholder, text: $text, icon: "magnifyingglass")
            .onSubmit(onSubmit)
    }
}

#Preview {
    SearchBar(text: .constant(""))
        .padding()
        .background(Color.swBackground)
}
