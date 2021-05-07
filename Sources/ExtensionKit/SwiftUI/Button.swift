import SwiftUI

public extension Button where Label == Image {
    
    /// Initialize button with system image and trailing action
    /// - Parameters:
    ///   - systemName: System image name
    ///   - action: action
    init(systemName: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: systemName)
        }
    }
    
    /// Initialize button with local image and trailing action
    /// - Parameters:
    ///   - systemName: System image name
    ///   - action: action
    init(imageName: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(imageName)
        }
    }

    /// Create a `Button` with foreground, background, shadow, cornerRadius
    /// - Parameters:
    ///   - titleColor: foreground color
    ///   - background: background color
    ///   - padding: padding
    ///   - shadow: shadow
    ///   - cornerRadius: corner radius
    /// - Returns: View
    func shadowButton(
        titleColor: Color = .white,
        background: Color = .blue,
        padding: (edges: Edge.Set, length: CGFloat) = (.all, 10),
        shadow: (radius: CGFloat, alpha: CGFloat, y: CGFloat) = (10, 0.15, 4),
        cornerRadius: CGFloat = 10
    ) -> some View {
        self
            .foregroundColor(titleColor)
            .background(background)
            .padding(padding.edges, padding.length)
            .shadow(color:
                        Color(
                            UIColor(white: 0,
                                    alpha: shadow.radius)
                        ), radius: shadow.radius, x: 0, y: shadow.y)
            .cornerRadius(cornerRadius)
    }
    
}
