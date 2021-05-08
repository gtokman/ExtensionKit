import UIKit

/// Struct modeling keyboard updates
public struct KeyboardInfo: Equatable {
    /// Keyboard height
    public var height: CGFloat = 0
    /// Keyboard animation curve
    public var animationCurve: UIView.AnimationCurve = UIView.AnimationCurve.easeInOut
    /// Keyboard animation duration
    public var animationDuration: TimeInterval = 0.0
    
    /// Create new
    public init() {}
    
    /// Is the keyboard visible
    public var isVisible: Bool {
        height != 0
    }
    
    mutating func update(with userInfo: [AnyHashable: Any]?) {
        if let value = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            self.height = value.height
        }
        if let value = userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber {
            if let curve = UIView.AnimationCurve(rawValue: value.intValue) {
                self.animationCurve = curve
            }
        }
        if let value = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            self.animationDuration = value.doubleValue
        }
    }
}
