import Foundation

protocol CartServiceProtocol: Sendable {
    func fetchCart(userId: Int) async throws -> CartDTO?
    func fetchExtraCarts(limit: Int) async throws -> [CartDTO]
}

struct CartService: CartServiceProtocol {
    let client: APIClientProtocol

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchCart(userId: Int) async throws -> CartDTO? {
        let response: CartListResponse = try await client.get(.cart(userId: userId))
        return response.carts.first
    }

    func fetchExtraCarts(limit: Int) async throws -> [CartDTO] {
        let response: CartListResponse = try await client.get(.carts(limit: limit))
        return response.carts
    }
}

struct MockCartService: CartServiceProtocol {
    func fetchCart(userId: Int) async throws -> CartDTO? {
        MockData.cartDTO
    }

    func fetchExtraCarts(limit: Int) async throws -> [CartDTO] {
        [MockData.cartDTO]
    }
}
