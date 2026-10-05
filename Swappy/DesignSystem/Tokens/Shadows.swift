import SwiftUI

struct SWShadow {
    let color: Color
    let radius: CGFloat
    let x: CGFloat
    let y: CGFloat

    static let soft = SWShadow(color: .black.opacity(0.08), radius: 12, x: 0, y: 4)
    static let card = SWShadow(color: .black.opacity(0.10), radius: 16, x: 0, y: 6)
    static let raised = SWShadow(color: .black.opacity(0.16), radius: 20, x: 0, y: 10)

    static func tinted(_ color: Color) -> SWShadow {
        SWShadow(color: color.opacity(0.28), radius: 16, x: 0, y: 8)
    }
}

extension View {
    func swShadow(_ shadow: SWShadow) -> some View {
        self.shadow(color: shadow.color, radius: shadow.radius, x: shadow.x, y: shadow.y)
    }
}
