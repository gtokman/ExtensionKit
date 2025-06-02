import UIKit

/// This generic protocol is used to enable shared element transitions between view controllers.
/// It defines the following requirements:
///
/// `sharedFrame`: Gets the frame of the shared element in window coordinates
/// `sharedView`: Gets the view of the shared element in window coordinates.
/// `config`: Optional configuration for the transition
/// `prepare`: A method to prepare the view controller just before transitioning
///
public protocol SharedTransitioning {
    var sharedFrame: CGRect { get }
    var sharedView: UIView? { get }
    var config: SharedTransitionConfig? { get }
    func prepare(for transition: TransitionType)
}

/// Default methods and properties of the `SharedTransitioning` protocol.
/// They're optional so view controllers don't need to implement them if they don't have to.
/// This means conforming types only need to implement `sharedFrame`.
///
public extension SharedTransitioning {
    var sharedView: UIView? { nil }
    var config: SharedTransitionConfig? { nil }
    func prepare(for transition: TransitionType) {}
}

public extension UIViewControllerContextTransitioning {
    /// A helper method that takes a transition context key (from/to view controller) and
    /// grabs the shared **frame** from the view controller(s) that will be used during the custom transition.
    ///
    /// We need this to calculate the starting and ending positions of a view during a transition animation.
    /// For example, when transitioning from a grid of photos to a detail view, it determines where the image
    /// is located in both screens.
    ///
    /// It returns the `sharedFrame` if the view controller conforms to `SharedTransitioning`.
    ///
    func sharedFrame(forKey key: UITransitionContextViewControllerKey) -> CGRect? {
        let viewController = viewController(forKey: key)
        
        // We need layoutIfNeeded() here because:
        // 1. The view hierarchy might not be fully laid out yet
        // 2. Any pending Auto Layout changes need to be applied
        // 3. Without it, frame calculations might be incorrect or zero
        viewController?.view.layoutIfNeeded()
        
        return (viewController as? SharedTransitioning)?.sharedFrame
    }

    /// A helper method that takes a transition context key (from/to view controller) and
    /// grabs the shared **view** from the view controller(s) that will be used during the custom transition.
    ///
    /// Essentially, this will be a fake "duplicated" view that appears to seamlessly travel across from the source
    /// view to the destination view, and only exists during the transition.
    ///
    /// It returns the `sharedView` if the view controller conforms to `SharedTransitioning` and
    /// requires it for the transition.
    ///
    func sharedView(forKey key: UITransitionContextViewControllerKey) -> UIView? {
        let viewController = viewController(forKey: key)
        viewController?.view.layoutIfNeeded()
        
        let sharedView = (viewController as? SharedTransitioning)?.sharedView
        return sharedView
    }
}

/// This is a configuration struct that controls various aspects of the shared element transition animation.
///
/// `duration`: How long the transition animation takes
/// `curve`: The timing function that controls the animation's acceleration/deceleration
/// `maskCornerRadius`: Controls the corner radius of the transitioning view
/// `overlayOpacity`: The opacity of the backdrop during transition
/// `interactionScaleFactor`: Controls max scale factor depending on interactive or default transition
/// `placeholderColor`: The color of the final frame of the transitioning view.
///
public struct SharedTransitionConfig {
    public var duration: CGFloat
    public var curve: CAMediaTimingFunction
    public var maskCornerRadius: CGFloat
    public var overlayOpacity: Float
    public var interactionScaleFactor: CGFloat = .zero
    public var placeholderColor: UIColor
}

public extension SharedTransitionConfig {
    // Default configuration for non-interactive transitions
    static var `default`: SharedTransitionConfig {
        .init(
            duration: 0.25,
            curve: CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94),
            maskCornerRadius: UIScreen.main.displayCornerRadius,
            overlayOpacity: 0.5,
            placeholderColor: .white
        )
    }

    // Configuration for interactive transitions (e.g., pan gesture)
    static var interactive: SharedTransitionConfig {
        .init(
            duration: 0.25,
            curve: CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94),
            maskCornerRadius: UIScreen.main.displayCornerRadius,
            overlayOpacity: 0.5,
            interactionScaleFactor: 0.6,
            placeholderColor: .white
        )
    }
    
    static var interpolation: SharedTransitionConfig {
        .init(
            duration: 0.35,
            curve: CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94),
            maskCornerRadius: 0,
            overlayOpacity: 0,
            placeholderColor: .systemBackground
        )
    }
}
