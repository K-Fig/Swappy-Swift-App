import Foundation

protocol UserServiceProtocol: Sendable {
    func fetchUser(id: Int) async throws -> User
}

struct UserService: UserServiceProtocol {
    let client: APIClientProtocol

    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }

    func fetchUser(id: Int) async throws -> User {
        try await client.get(.user(id: id))
    }
}

struct MockUserService: UserServiceProtocol {
    func fetchUser(id: Int) async throws -> User {
        MockData.sessionUser
    }
}
