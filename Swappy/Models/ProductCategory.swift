import Foundation

struct ProductCategory: Codable, Hashable, Identifiable {
    let slug: String
    let name: String
    let url: String

    var id: String { slug }

    var icon: String {
        switch slug {
        case "smartphones": "iphone"
        case "laptops": "laptopcomputer"
        case "fragrances": "drop.fill"
        case "skincare": "sparkles"
        case "groceries": "cart.fill"
        case "home-decoration": "house.fill"
        case "furniture": "sofa.fill"
        case "tops", "mens-shirts", "womens-dresses", "womens-shirts": "tshirt.fill"
        case "womens-jewellery", "mens-watches", "womens-watches": "crown.fill"
        case "womens-bags": "bag.fill"
        case "womens-shoes", "mens-shoes": "shoe.2.fill"
        case "mens-shorts": "figure.walk"
        case "tablets": "ipad"
        case "mobile-accessories": "cable.connector"
        case "sunglasses": "sun.max.fill"
        case "automotive": "car.fill"
        case "motorcycle": "bicycle"
        case "lighting": "lightbulb.fill"
        case "sports-accessories": "sportscourt.fill"
        case "kitchen-accessories": "fork.knife"
        case "beauty": "paintbrush.pointed.fill"
        default: "tag.fill"
        }
    }
}
