import Foundation

private final class BundleToken {}

enum TestFixtures {
    static let bundle = Bundle(for: BundleToken.self)

    static func data(_ name: String) -> Data {
        guard let url = bundle.url(forResource: name, withExtension: "json") else {
            fatalError("Missing fixture: \(name).json")
        }
        return try! Data(contentsOf: url)
    }
}
