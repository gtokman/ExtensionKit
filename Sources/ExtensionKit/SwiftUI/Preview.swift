import SwiftUI

/// Preview content on iPhone 12 pro in light mode, iPhone 12 mini in dark mode
public struct Preview<Content: View>: View {
    let content: Content

    /// Create a preview for iPhone 12 pro and iPhone 12 mini
    /// - Parameter content: Content
    public init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        Group {
            self.content
                .environment(\.colorScheme, .light)
                .preferredColorScheme(.light)
                .navigationBarHidden(true)
                .previewDevice("iPhone 12 Pro")
                .previewDisplayName("Pro, light mode")

            self.content
                .environment(\.colorScheme, .dark)
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
                .previewDevice("iPhone 12 mini")
                .previewDisplayName("Mini, dark mode")
        }
    }
}
