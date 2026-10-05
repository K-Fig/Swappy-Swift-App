import SwiftUI

extension Color {
    // Brand
    static let swPrimary = Color(hex: 0xFF4F3D)
    static let swSecondary = Color(hex: 0xFFC83D)
    static let swMint = Color(hex: 0x2EE6A6)
    static let swSky = Color(hex: 0x3DB5FF)
    static let swGrape = Color(hex: 0x9B5DE5)

    // Surfaces
    static let swBackground = Color(hex: 0xFBF9F6)
    static let swSurface = Color.white
    static let swSurfaceAlt = Color(hex: 0xF2EFEA)
    static let swBorder = Color(hex: 0xE8E3DC)

    // Text
    static let swTextPrimary = Color(hex: 0x1F1B16)
    static let swTextSecondary = Color(hex: 0x6F6A62)
    static let swTextInverse = Color.white

    // Semantic
    static let swSuccess = Color(hex: 0x1FAE6B)
    static let swWarning = Color(hex: 0xFFA500)
    static let swDanger = Color(hex: 0xE5484D)

    // Order status
    static let swStatusProcessing = Color(hex: 0x3DB5FF)
    static let swStatusShipped = Color(hex: 0x9B5DE5)
    static let swStatusOutForDelivery = Color(hex: 0xB8720A)
    static let swStatusDelivered = Color(hex: 0x1FAE6B)
    static let swStatusCancelled = Color(hex: 0x6F6A62)
}

extension Color {
    init(hex: UInt32, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
