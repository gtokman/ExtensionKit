import Foundation
import UIKit

extension Notification {
    
    /// Get keyboard info updates
    var keyboardInfo: KeyboardInfo {
        var info = KeyboardInfo()
        if let value = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            info.height = value.height
        }
        if let value = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            if let curve = UIView.AnimationCurve(rawValue: value.intValue) {
                info.animationCurve = curve
            }
        }
        if let value = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            info.animationDuration = value.doubleValue
        }
        return info
    }
}
