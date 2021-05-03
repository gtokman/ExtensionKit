import Foundation
import UIKit

extension Notification {
    
    /// Struct modeling keyboard updates
    public struct KeyboardInfo {
        /// Keyboard height
        public var height: CGFloat = 0
        /// Keyboard animation curve
        public var animationCurve: UIView.AnimationCurve = UIView.AnimationCurve.easeInOut
        /// Keyboard animation duration
        public var animationDuration: TimeInterval = 0.0
        /// Is the keyboard visible
        public var isVisible: Bool {
            height != 0
        }
    }
    
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
