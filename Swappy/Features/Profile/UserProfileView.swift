import SwiftUI

struct UserProfileView: View {
    @Environment(SessionStore.self) private var session
    @Environment(FavoritesStore.self) private var favorites
    @Environment(MessagesStore.self) private var messages
    @Environment(\.openRoute) private var openRoute

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpacing.lg) {
                if let user = session.currentUser {
                    ProfileHeader(
                        name: user.fullName,
                        subtitle: user.email,
                        avatarURL: user.imageURL,
                        initials: user.initials
                    )
                } else {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, SWSpacing.lg)
                }

                VStack(spacing: SWSpacing.xs) {
                    MenuRow(title: "My Orders", icon: "shippingbox.fill") { openRoute(.ordersList) }
                    SWDivider()
                    MenuRow(title: "Favourites", icon: "heart.fill", tint: .swGrape, trailingText: favorites.count > 0 ? "\(favorites.count)" : nil) {
                        openRoute(.favorites)
                    }
                    SWDivider()
                    MenuRow(title: "Messages", icon: "bubble.left.and.bubble.right.fill", tint: .swSky, trailingText: messages.conversations.isEmpty ? nil : "\(messages.conversations.count)") {
                        openRoute(.inbox)
                    }
                    SWDivider()
                    MenuRow(title: "Help Center", icon: "questionmark.circle.fill", tint: .swSecondary) {
                        openRoute(.help)
                    }
                }

                if let user = session.currentUser {
                    VStack(alignment: .leading, spacing: SWSpacing.sm) {
                        SectionHeader(title: "Account info")
                        VStack(alignment: .leading, spacing: SWSpacing.xs) {
                            infoRow(label: "Email", value: user.email)
                            infoRow(label: "Phone", value: user.phone)
                            infoRow(label: "Address", value: user.formattedAddress)
                        }
                        .padding(SWSpacing.md)
                        .background(Color.swSurface)
                        .clipShape(RoundedRectangle(cornerRadius: SWRadius.md, style: .continuous))
                        .swShadow(.soft)
                    }
                }
            }
            .padding(SWSpacing.md)
        }
        .background(Color.swBackground)
        .navigationTitle("Me")
        .task {
            await session.loadCurrentUserIfNeeded()
        }
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .font(.swCaption)
                .foregroundStyle(Color.swTextSecondary)
                .frame(width: 80, alignment: .leading)
            Text(value)
                .font(.swBody)
                .foregroundStyle(Color.swTextPrimary)
        }
    }
}

#Preview {
    NavigationStack {
        UserProfileView()
            .withAppRouting()
    }
    .environment(SessionStore())
    .environment(FavoritesStore())
    .environment(MessagesStore())
}
