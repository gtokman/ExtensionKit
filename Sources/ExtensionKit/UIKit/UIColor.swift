#if canImport(UIKit)

import UIKit

#endif

public extension UIColor {
    
    /// New color from RGB value
    /// - Parameters:
    ///   - rgbValue: value
    ///   - alpha: alpha
    convenience init(rgbValue: UInt, alpha: CGFloat = 1) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    /// Color from HEX
    /// - Parameter hexCode: Hex w/o `#`
    convenience init(hexCode: String, alpha: CGFloat = 1) {
        var cString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue:UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: alpha)
        }
    }
    
    /// Check whether self is a light/bright color.
    /// https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
    var isLight: Bool {
        guard let components = cgColor.components, components.count > 2 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness > 0.5
    }
    
    /// Check whether self is a light/bright color.
    /// https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright
    var isExtremelyLight: Bool {
        guard let components = cgColor.components, components.count > 2 else { return false }
        let brightness = ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
        return brightness > 0.9
    }
    
    /// Random color
    /// - Parameter alpha: alpha
    /// - Returns: new color
    static func random(alpha: CGFloat = 1.0) -> UIColor {
         let r = CGFloat.random(in: 0...1)
         let g = CGFloat.random(in: 0...1)
         let b = CGFloat.random(in: 0...1)
         
         return UIColor(red: r, green: g, blue: b, alpha: alpha)
     }
    
    /// Darken color
    /// - Parameter percentage: percentage
    /// - Returns: new color
    func lighten(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: abs(percentage) )
    }

    /// Darken color
    /// - Parameter percentage: percentage
    /// - Returns: new color
    func darken(by percentage: CGFloat = 30.0) -> UIColor {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    private func adjust(by percentage: CGFloat = 30.0) -> UIColor {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return self
        }
    }
}
