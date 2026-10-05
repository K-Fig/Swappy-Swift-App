import SwiftUI

enum Route: Hashable {
    case search
    case product(Int)
    case category(slug: String, title: String)
    case seller(Int)
    case order(Int)
    case chat(UUID)
    case inbox
    case ordersList
    case favorites
    case help
    case faqDetail(Int)
    case reportIssue(orderId: Int)
    case checkout
    case orderConfirmation(Int)
}

private struct OpenRouteKey: EnvironmentKey {
    static let defaultValue: @MainActor (Route) -> Void = { _ in }
}

private struct PopToRootKey: EnvironmentKey {
    static let defaultValue: @MainActor () -> Void = {}
}

extension EnvironmentValues {
    var openRoute: @MainActor (Route) -> Void {
        get { self[OpenRouteKey.self] }
        set { self[OpenRouteKey.self] = newValue }
    }

    var popToRoot: @MainActor () -> Void {
        get { self[PopToRootKey.self] }
        set { self[PopToRootKey.self] = newValue }
    }
}
