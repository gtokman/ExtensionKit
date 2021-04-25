#if canImport(SwiftUI)

import SwiftUI

#endif

@available(iOS 13.0, macOS 10.15, *)
public extension Color {
    
    /// Initialize with HEX
    /// - Parameter hex: HEX
    init(hex: String) {
        self.init(UIColor(hexCode: hex))
    }
    
    /// Generate a random color
    /// - Parameter opacity: opacity
    /// - Returns: New color
    static func random(opacity: CGFloat = 1.0) -> Color{
        return Color(.random(alpha: opacity))
    }

    /// Lighten color
    /// - Parameter percentage: percentage (1 -100), default: 30
    /// - Returns: new color
    @available(iOS 14.0, *)
    func lighten(by percentage: CGFloat = 30.0) -> Color {
        let uiColor = UIColor(self)
        let adjustedColor = uiColor.lighten(by: percentage)
        return Color(adjustedColor)
    }
    
    /// Darken color
    /// - Parameter percentage: percentage (1 -100), default: 30
    /// - Returns: new color
    @available(iOS 14.0, *)
    func darken(by percentage: CGFloat = 30.0) -> Color {
        let uiColor = UIColor(self)
        let adjustedColor = uiColor.darken(by: percentage)
        return Color(adjustedColor)
    }
}
