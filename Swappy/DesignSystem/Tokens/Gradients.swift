import SwiftUI

extension LinearGradient {
    static let swSunset = LinearGradient(colors: [.swPrimary, .swSecondary], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let swOcean = LinearGradient(colors: [.swSky, .swGrape], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let swFresh = LinearGradient(colors: [.swMint, .swSky], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let swCandy = LinearGradient(colors: [.swGrape, .swPrimary], startPoint: .leading, endPoint: .trailing)
}
