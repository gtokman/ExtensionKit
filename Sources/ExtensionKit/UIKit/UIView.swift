#if canImport(UIKit)

import UIKit

#endif
import AudioToolbox

public extension UIView {
    /// This computed property converts a view's frame to window coordinates.
    /// We do this because we need to know the exact position of a view in the
    /// window's coordinate space (i.e. the physical screen), not just its local superview.
    ///
    var frameInWindow: CGRect? {
        superview?.convert(frame, to: nil)
    }

    /// A convenience wrapper around `UIView.animate` that adds support for
    /// custom timing functions (`CAMediaTimingFunction`).
    ///
    static func animate(
        duration: TimeInterval,
        curve: CAMediaTimingFunction? = nil,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        completion: (() -> Void)? = nil
    ) {
        // Begin CATransaction to set timing curve
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(curve)
        
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: animations,
            completion: { _ in completion?() }
        )
        
        // Commit the transaction
        CATransaction.commit()
    }

    /// Add border using path
    /// - Parameters:
    ///   - cornerRadius: radius
    ///   - color: color
    ///   - width: width
    ///   - targetBounds: bounds or view bounds
    func addCleanBorder(cornerRadius: CGFloat, color: UIColor, width: CGFloat, targetBounds: CGRect?) {
        let path = UIBezierPath(roundedRect: targetBounds ?? bounds, cornerRadius: cornerRadius)
        return addCleanBorder(using: path, color: color, width: width, targetBounds: targetBounds)
    }

    /// Add border using path
    /// - Parameters:
    ///   - roundingCorners: Corners to round
    ///   - cornerRadii: radius
    ///   - color: color
    ///   - width: width
    ///   - targetBounds: view bounds
    func addCleanBorder(roundingCorners: UIRectCorner, cornerRadii: CGSize, color: UIColor, width: CGFloat, targetBounds: CGRect?) {
        let path = UIBezierPath(roundedRect: targetBounds ?? bounds, byRoundingCorners: roundingCorners, cornerRadii: cornerRadii)
        return addCleanBorder(using: path, color: color, width: width, targetBounds: targetBounds)
    }

    private func addCleanBorder(using path: UIBezierPath, color: UIColor, width: CGFloat, targetBounds: CGRect?) {
        // Setting up a mask that clips receiver's content
        if layer.mask?.name == "addCleanBorderMaskLayerName" {
            layer.mask = nil
        }
        let maskLayer = CAShapeLayer()
        maskLayer.name = "addCleanBorderMaskLayerName"
        maskLayer.frame = targetBounds ?? bounds
        maskLayer.path = path.cgPath
        layer.mask = maskLayer

        // Setting up an additional layer that acts like a normal border.
        if let borderLayer = layer.sublayers?.first(where: { $0.name == "addCleanBorderBorderLayerName" }) {
            borderLayer.removeFromSuperlayer()
        }
        let borderLayer = CAShapeLayer()
        borderLayer.name = "addCleanBorderBorderLayerName"
        borderLayer.frame = targetBounds ?? bounds
        borderLayer.path = path.cgPath
        borderLayer.strokeColor = color.cgColor
        borderLayer.lineWidth = width * 2
        borderLayer.fillColor = nil
        layer.addSublayer(borderLayer)
    }

    /// Set anchor point on layer
    var anchorPoint: CGPoint {
        get {
            return layer.anchorPoint
        }
        set {
            let oldOrigin = frame.origin
            layer.anchorPoint = newValue
            let newOrigin = frame.origin
            let transition = CGPoint(x: newOrigin.x - oldOrigin.x, y: newOrigin.y - oldOrigin .y)
            center = CGPoint(x: center.x - transition.x, y: center.y - transition.y)
        }
    }

    /// Set corner radius on layer
    @IBInspectable var layerCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    /// Set border width on layer
    @IBInspectable var layerBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Set a border color on layer
    @IBInspectable var layerBorderColor: UIColor? {
        get {
            return layer.borderColor == nil ? nil : UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    enum GradientLayerChangingDirection {
        case top, bottom, left, right
    }

    /// Add a transparent gradient layer
    ///
    /// - Parameters:
    ///   - frame: View frame (default to bounds)
    ///   - toColor: Color to add
    ///   - minAlpha: Alpha
    ///   - maxAlpha: End alpha
    ///   - start: Start direction
    ///   - end: End direction
    @discardableResult
    func addTransparentGradientLayer(frame: CGRect? = nil, toColor: UIColor, minAlpha: CGFloat, maxAlpha: CGFloat, from start: GradientLayerChangingDirection, to end: GradientLayerChangingDirection) -> CAGradientLayer {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
        toColor.getRed(&r, green: &g, blue: &b, alpha: nil)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame ?? self.bounds
        gradientLayer.colors = [minAlpha, maxAlpha].map { UIColor(red: r, green: g, blue: b, alpha: $0).cgColor }
        gradientLayer.locations = [0, 1]

        switch start {
        case .left:
            gradientLayer.startPoint.x = 0
        case .right:
            gradientLayer.startPoint.x = 1
        case .top:
            gradientLayer.startPoint.y = 0
        case .bottom:
            gradientLayer.startPoint.y = 1
        }

        switch end {
        case .left:
            gradientLayer.endPoint.x = 1
        case .right:
            gradientLayer.endPoint.x = 0
        case .top:
            gradientLayer.endPoint.y = 0
        case .bottom:
            gradientLayer.endPoint.y = 1
        }

        layer.addSublayer(gradientLayer)
        return gradientLayer
    }

    /// Resizes `self.frame` so as to fit the constraint-based layout.
    func sizeToFitConstraintedBasedLayout() {
        frame.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }

    /// Commit a shake animation and vibrate to indicate the occured error.
    func shakeToIndicateError() {
        commitShakeAnimation()
        if #available(iOS 10.0, *) {
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        } else {
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }

    private func commitShakeAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0]
        layer.add(animation, forKey: "shake")
    }

    /// New drop shadow by adding new layer
    /// - Parameters:
    ///   - shadowColor: color
    ///   - fillColor: fill default: white
    ///   - opacity: opacity default 20%
    ///   - offset: offset default y: 1
    ///   - radius: radius (blur) default 10
    /// - Returns: new layer
    func dropRealShadow(shadowColor: UIColor = UIColor.black, fillColor: UIColor = UIColor.white, opacity: Float = 0.2, offset: CGSize = CGSize(width: 0.0, height: 1.0), radius: CGFloat = 10) -> CAShapeLayer {

        let shadowLayer = CAShapeLayer()
        let bounds = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height / 2)
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowLayer.fillColor = fillColor.cgColor
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offset
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = radius
        shadowLayer.name = "shadow"
        shadowLayer.frame.size = CGSize(width: shadowLayer.frame.size.width / 2, height: shadowLayer.frame.size.height / 2)
        layer.insertSublayer(shadowLayer, at: 0)
        return shadowLayer
    }

    /// Draw a simple drop shadow for the views layer
    /// - Parameters:
    ///   - color: color
    ///   - opacity: opacity default: 50%
    ///   - offSet: offset
    ///   - radius: radius (blur) default 1
    ///   - scale:  scale default: true
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    /// Constrain view to parent view
    /// - Parameters:
    ///   - view: Parent view
    ///   - insets: Margin insets
    func fillParent(view: UIView, with insets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor
                .constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: insets.top),
            self.bottomAnchor
                .constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: insets.bottom),
            self.leadingAnchor
                .constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: insets.left),
            self.trailingAnchor
                .constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: insets.right),
        ])
    }
    
    /// Create a view with a clear background
    /// - Returns: UIView
    static func clear() -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
}
