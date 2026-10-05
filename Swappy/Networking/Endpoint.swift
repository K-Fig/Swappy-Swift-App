import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []

    var url: URL? {
        var components = URLComponents(string: "https://dummyjson.com" + path)
        if !queryItems.isEmpty {
            components?.queryItems = queryItems
        }
        return components?.url
    }
}

extension Endpoint {
    static func products(limit: Int, skip: Int) -> Endpoint {
        Endpoint(path: "/products", queryItems: [
            .init(name: "limit", value: String(limit)),
            .init(name: "skip", value: String(skip)),
        ])
    }

    static func searchProducts(query: String, limit: Int, skip: Int) -> Endpoint {
        Endpoint(path: "/products/search", queryItems: [
            .init(name: "q", value: query),
            .init(name: "limit", value: String(limit)),
            .init(name: "skip", value: String(skip)),
        ])
    }

    static func productsByCategory(_ slug: String, limit: Int, skip: Int) -> Endpoint {
        Endpoint(path: "/products/category/\(slug)", queryItems: [
            .init(name: "limit", value: String(limit)),
            .init(name: "skip", value: String(skip)),
        ])
    }

    static func product(id: Int) -> Endpoint {
        Endpoint(path: "/products/\(id)")
    }

    static let categories = Endpoint(path: "/products/categories")

    static func user(id: Int) -> Endpoint {
        Endpoint(path: "/users/\(id)")
    }

    static func cart(userId: Int) -> Endpoint {
        Endpoint(path: "/carts/user/\(userId)")
    }

    static func carts(limit: Int) -> Endpoint {
        Endpoint(path: "/carts", queryItems: [.init(name: "limit", value: String(limit))])
    }
}
