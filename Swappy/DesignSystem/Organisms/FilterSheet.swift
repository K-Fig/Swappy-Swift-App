import SwiftUI

struct FilterSheet: View {
    @Binding var filterState: ProductFilterState
    @Environment(\.dismiss) private var dismiss
    @State private var draft: ProductFilterState

    init(filterState: Binding<ProductFilterState>) {
        self._filterState = filterState
        self._draft = State(initialValue: filterState.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Availability") {
                    Toggle("In stock only", isOn: $draft.inStockOnly)
                }

                Section("Price range") {
                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        Text("$\(Int(draft.minPrice)) – $\(Int(draft.maxPrice))")
                            .font(.swBodyEmphasis)
                        Slider(value: $draft.minPrice, in: 0...draft.maxPrice, step: 10)
                        Slider(value: $draft.maxPrice, in: draft.minPrice...2000, step: 10)
                    }
                    .padding(.vertical, SWSpacing.xxs)
                }
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Reset") { draft = ProductFilterState() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        filterState = draft
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FilterSheet(filterState: .constant(ProductFilterState()))
}
