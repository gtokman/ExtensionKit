import UIKit

/// Struct modeling keyboard updates
public struct KeyboardInfo {
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
}
