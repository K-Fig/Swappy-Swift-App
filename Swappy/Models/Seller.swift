import Foundation

struct Seller: Hashable, Identifiable {
    let id: Int
    let name: String
    let avatarURL: URL?
    let initials: String
    let city: String
    let country: String
    let rating: Double
    let listingsCount: Int
}
