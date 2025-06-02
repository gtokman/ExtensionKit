#if canImport(UIKit)

import UIKit

#endif

public extension UIButton {
    
    @IBInspectable var normalStateBackgroundColor: UIColor? {
        // not gettable
        get { return nil }
        set {
            if let color = newValue {
                setBackgroundColor(color, for: .normal)
            }
        }
    }
    @IBInspectable var disabledStateBackgroundColor: UIColor? {
        // not gettable
        get { return nil }
        set {
            if let color = newValue {
                setBackgroundColor(color, for: .disabled)
            }
        }
    }
    @IBInspectable var highlightedStateBackgroundColor: UIColor? {
        // not gettable
        get { return nil }
        set {
            if let color = newValue {
                setBackgroundColor(color, for: .highlighted)
            }
        }
    }
    @IBInspectable var selectedStateBackgroundColor: UIColor? {
        // not gettable
        get { return nil }
        set {
            if let color = newValue {
                setBackgroundColor(color, for: .selected)
            }
        }
    }

    /// Set background color for state
    /// - Parameters:
    ///   - color: color
    ///   - state: state
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        if let image = UIImage.image(withPureColor: color, for: rect, rounded: false) {
            setBackgroundImage(image, for: state)
        } else {
            dprint("UIButton.setBackgroundColor(_:for:) got called but returning a nil image!")
        }
    }
    
    var isTitleImagePositionReversed: Bool {
        get {
            return transform == .identity
        }
        set {
            let reversingTransform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            transform = reversingTransform
            titleLabel?.transform = reversingTransform
            imageView?.transform = reversingTransform
        }
    }
    
    var backgroundImageView: UIImageView? {
        return subviews.first {
            if let backgroundImageView = $0 as? UIImageView, backgroundImageView != imageView {
                return true
            }
            return false
        } as? UIImageView
    }
    
    
    private class ButtonClosureWrapper {
        
        let closure: () -> Void
        
        init (_ closure: @escaping () -> Void) {
            self.closure = closure
        }
        
        @objc func invoke () {
            closure()
        }
    }

}
