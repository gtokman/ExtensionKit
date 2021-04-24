import UIKit
import AudioToolbox

// These methods are for fixing a bug that `layer.content` exceeds its border programmically set by those `layer.borderxxx`.
public extension UIView {


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

}
