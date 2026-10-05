import SwiftUI

struct ProfileHeader: View {
    let name: String
    let subtitle: String
    let avatarURL: URL?
    let initials: String
    var stats: [(value: String, label: String)] = []
    var trailingAction: (icon: String, action: () -> Void)? = nil

    var body: some View {
        VStack(spacing: SWSpacing.md) {
            HStack(spacing: SWSpacing.md) {
                AvatarView(url: avatarURL, initials: initials, size: 72)
                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.swTitle)
                        .foregroundStyle(Color.swTextPrimary)
                    Text(subtitle)
                        .font(.swCaption)
                        .foregroundStyle(Color.swTextSecondary)
                }
                Spacer()
                if let trailingAction {
                    SWIconButton(icon: trailingAction.icon, action: trailingAction.action)
                }
            }

            if !stats.isEmpty {
                HStack {
                    ForEach(Array(stats.enumerated()), id: \.offset) { _, stat in
                        StatTile(value: stat.value, label: stat.label)
                    }
                }
                .padding(SWSpacing.sm)
                .background(Color.swSurfaceAlt)
                .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
            }
        }
    }
}

#Preview {
    ProfileHeader(
        name: "Marcus Reed",
        subtitle: "Austin, United States",
        avatarURL: MockData.seller.avatarURL,
        initials: MockData.seller.initials,
        stats: [("18", "Listings"), ("4.6", "Rating"), ("2y", "Selling")],
        trailingAction: ("square.and.arrow.up", {})
    )
    .padding()
    .background(Color.swBackground)
}
