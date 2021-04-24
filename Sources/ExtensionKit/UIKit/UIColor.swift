#if canImport(UIKit)

import UIKit

#endif

public extension UIColor {
    
    /// New color from RGB value
    /// - Parameters:
    ///   - rgbValue: value
    ///   - alpha: alpha
    convenience init(rgbValue: UInt, alpha: CGFloat) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
    
    convenience init(rgbValue: UInt) {
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: 1)
    }
    
    
    /// Color from HEX
    /// - Parameter hexCode: Hex w/o `#`
    convenience init(hexCode: String) {
        var cString:String = hexCode.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            self.init()
        } else {
            var rgbValue:UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1)
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

}
