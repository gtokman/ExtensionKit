import SwiftUI
import UIKit

@available(iOS 13.0, macOS 10.15, *)
public extension Color {
    
    /// Initialize with HEX
    /// - Parameter hex: HEX UInt value
    /// - Returns: Color
    static func hex(_ hex: UInt, alpha: Double = 1) -> Self {
      Self(
        red: Double((hex & 0xff0000) >> 16) / 255,
        green: Double((hex & 0x00ff00) >> 8) / 255,
        blue: Double(hex & 0x0000ff) / 255,
        opacity: alpha
      )
    }
    
    /// Initialize with HEX
    /// - Parameter hex: HEX String value
    /// - Returns: Color
    static func hex(_ hex: String, alpha: CGFloat = 1) -> Self {
        self.init(UIColor(hexCode: hex, alpha: alpha))
    }
    
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
    
    @available(iOS 14.0, *)
    /// Inverse color
    var inverted: Color {
        var a: CGFloat = 0.0, r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0
        return UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
            ? Color(UIColor(red: 1.0-r, green: 1.0-g, blue: 1.0-b, alpha: a))
            : .black
    }
    
    /// Create a color with a dark and light mode UIColor
    /// - Parameters:
    ///   - light: light color
    ///   - dark: dark color
    /// - Returns: Color
    static func dynamicColor(light: UIColor, dark: UIColor) -> Color {
        self.init(UIColor.dynamicColor(light: light, dark: dark))
    }
}
