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

public protocol KeyboardObserver {
    func registerForKeyboardNotifications()
    func unregisterFromKeyboardNotifications()

    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func keyboardWillChangeFrame(_ notification: Notification)

    func keyboardWillChangeToRect(_ rect: CGRect,
                                  duration: TimeInterval,
                                  curve: UIView.AnimationCurve)
}

public extension KeyboardObserver where Self: UIViewController {
    func registerForKeyboardNotifications() {
        let defaultCenter = NotificationCenter.default

        _ = defaultCenter.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillShow(notification)
        }
        _ = defaultCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillHide(notification)
        }
        _ = defaultCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillChangeFrame(notification)
        }
    }

    func unregisterFromKeyboardNotifications() {
        let defaultCenter = NotificationCenter.default

        defaultCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        defaultCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        defaultCenter.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let rectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            else {
                return
        }

        if let curve = UIView.AnimationCurve(rawValue: curveInfo.intValue) {
            self.keyboardWillChangeToRect(rectValue.cgRectValue, duration: duration, curve: curve)
        }
    }

    func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let rectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            else {
                return
        }

        var rect = rectValue.cgRectValue

        if let delegate = UIApplication.shared.delegate {
            if let optionalWindow = delegate.window, let window = optionalWindow {
                if rect.origin.y > window.bounds.height {
                    rect.origin.y = window.bounds.height
                }
            }
        }
        if let curve = UIView.AnimationCurve(rawValue: curveInfo.intValue) {
            self.keyboardWillChangeToRect(rect, duration: duration, curve: curve)
        }
    }

    func keyboardWillChangeFrame(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let rectValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curveInfo = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            else {
                return
        }

        if let curve = UIView.AnimationCurve(rawValue: curveInfo.intValue) {
            self.keyboardWillChangeToRect(rectValue.cgRectValue, duration: duration, curve: curve)
        }
    }

    func keyboardWillChangeToRect(_ rect: CGRect, duration: TimeInterval, curve: UIView.AnimationCurve) { }

    func animateWithKeyboard(
        notification: Notification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double

        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue

        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)

            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }

        // Start the animation
        animator.startAnimation()
    }
}
