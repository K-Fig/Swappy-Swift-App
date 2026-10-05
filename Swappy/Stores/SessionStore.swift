import Foundation

@Observable
@MainActor
final class SessionStore {
    private(set) var currentUser: User?
    private(set) var isLoading = false
    private(set) var loadError: Error?

    private let userService: UserServiceProtocol
    private let sessionUserId = 1

    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }

    func loadCurrentUserIfNeeded() async {
        guard currentUser == nil else { return }
        isLoading = true
        loadError = nil
        do {
            currentUser = try await userService.fetchUser(id: sessionUserId)
        } catch {
            loadError = error
        }
        isLoading = false
    }
}
