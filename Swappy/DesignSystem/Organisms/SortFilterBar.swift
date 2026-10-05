import SwiftUI

enum ProductSortOption: String, CaseIterable, Identifiable {
    case relevance = "Relevance"
    case ratingHighToLow = "Top rated"
    case priceLowToHigh = "Price: Low to High"
    case priceHighToLow = "Price: High to Low"

    var id: String { rawValue }
}

struct ProductFilterState: Equatable {
    var inStockOnly: Bool = false
    var minPrice: Double = 0
    var maxPrice: Double = 2000

    var isActive: Bool {
        inStockOnly || minPrice > 0 || maxPrice < 2000
    }

    var activeCount: Int {
        (inStockOnly ? 1 : 0) + ((minPrice > 0 || maxPrice < 2000) ? 1 : 0)
    }
}

struct SortFilterBar: View {
    @Binding var sortOption: ProductSortOption
    @Binding var filterState: ProductFilterState
    @State private var showingSortMenu = false
    @State private var showingFilterSheet = false

    var body: some View {
        HStack(spacing: SWSpacing.xs) {
            Menu {
                ForEach(ProductSortOption.allCases) { option in
                    Button(option.rawValue) { sortOption = option }
                }
            } label: {
                SWChip(title: sortOption.rawValue, icon: "arrow.up.arrow.down", isSelected: false, action: {})
            }

            SWChip(
                title: filterState.activeCount > 0 ? "Filters (\(filterState.activeCount))" : "Filters",
                icon: "slider.horizontal.3",
                isSelected: filterState.isActive,
                action: { showingFilterSheet = true }
            )

            if filterState.inStockOnly {
                SWChip(title: "In stock", isSelected: true) { filterState.inStockOnly = false }
            }

            Spacer()
        }
        .sheet(isPresented: $showingFilterSheet) {
            FilterSheet(filterState: $filterState)
        }
    }
}

#Preview {
    SortFilterBar(sortOption: .constant(.relevance), filterState: .constant(ProductFilterState()))
        .padding()
        .background(Color.swBackground)
}
