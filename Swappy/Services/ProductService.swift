import Foundation

protocol ProductServiceProtocol: Sendable {
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductListResponse
    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductListResponse
    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductListResponse
    func fetchCategories() async throws -> [ProductCategory]
    func fetchProduct(id: Int) async throws -> Product
}

struct ProductService: ProductServiceProtocol {
    let client: APIClientProtocol

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchProducts(limit: Int, skip: Int) async throws -> ProductListResponse {
        try await client.get(.products(limit: limit, skip: skip))
    }

    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        try await client.get(.searchProducts(query: query, limit: limit, skip: skip))
    }

    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        try await client.get(.productsByCategory(category, limit: limit, skip: skip))
    }

    func fetchCategories() async throws -> [ProductCategory] {
        try await client.get(.categories)
    }

    func fetchProduct(id: Int) async throws -> Product {
        try await client.get(.product(id: id))
    }
}

struct MockProductService: ProductServiceProtocol {
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductListResponse {
        ProductListResponse(products: MockData.products, total: MockData.products.count, skip: skip, limit: limit)
    }

    func searchProducts(query: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        let filtered = MockData.products.filter { $0.title.localizedCaseInsensitiveContains(query) }
        return ProductListResponse(products: filtered, total: filtered.count, skip: skip, limit: limit)
    }

    func fetchProducts(category: String, limit: Int, skip: Int) async throws -> ProductListResponse {
        let filtered = MockData.products.filter { $0.category == category }
        return ProductListResponse(products: filtered, total: filtered.count, skip: skip, limit: limit)
    }

    func fetchCategories() async throws -> [ProductCategory] {
        MockData.categories
    }

    func fetchProduct(id: Int) async throws -> Product {
        guard let product = MockData.products.first(where: { $0.id == id }) else {
            throw APIError.badStatus(404)
        }
        return product
    }
}
