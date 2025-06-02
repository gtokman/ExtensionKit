import UIKit

public extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            guard let window = windowScene?.windows.first else { return false }

            return window.safeAreaInsets.top > 20
        }

        if #available(iOS 11.0, *) {
            let top = UIApplication.keyWindow?.safeAreaInsets.top ?? .zero
            return top > 20
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    var safeAreaInsets: UIEdgeInsets {
        return UIApplication.keyWindow?.safeAreaInsets ?? .zero
    }

    var topInset: CGFloat {
        return safeAreaInsets.top
    }

    var bottomInset: CGFloat {
        return safeAreaInsets.bottom
    }
    
    var displaySize: CGSize {
        return UIApplication.keyWindow?.bounds.size ?? .zero
    }

    var displayCornerRadius: CGFloat {
        UIScreen.main.displayCornerRadius
    }
}
