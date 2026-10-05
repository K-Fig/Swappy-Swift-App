import Foundation

struct User: Codable, Hashable, Identifiable {
    struct Address: Codable, Hashable {
        let address: String
        let city: String
        let state: String
        let postalCode: String
        let country: String
    }

    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let username: String
    let image: String
    let address: Address

    var fullName: String { "\(firstName) \(lastName)" }

    var initials: String {
        let first = firstName.first.map(String.init) ?? ""
        let last = lastName.first.map(String.init) ?? ""
        return (first + last).uppercased()
    }

    var imageURL: URL? { URL(string: image) }

    var formattedAddress: String {
        "\(address.address), \(address.city), \(address.state) \(address.postalCode)"
    }
}
