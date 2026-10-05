import SwiftUI

struct AvatarView: View {
    let url: URL?
    var initials: String = ""
    var size: CGFloat = 48

    var body: some View {
        ZStack {
            if url != nil {
                RemoteImage(url: url, cornerRadius: size / 2, contentMode: .fill)
            } else {
                Circle()
                    .fill(LinearGradient.swOcean)
                Text(initials)
                    .font(.system(size: size * 0.38, weight: .bold, design: .rounded))
                    .foregroundStyle(Color.swTextInverse)
            }
        }
        .frame(width: size, height: size)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.swBorder, lineWidth: 1))
    }
}

#Preview {
    HStack(spacing: SWSpacing.md) {
        AvatarView(url: URL(string: "https://dummyjson.com/icon/emilys/128"), size: 64)
        AvatarView(url: nil, initials: "JS", size: 64)
        AvatarView(url: nil, initials: "AK", size: 36)
    }
    .padding()
    .background(Color.swBackground)
}
