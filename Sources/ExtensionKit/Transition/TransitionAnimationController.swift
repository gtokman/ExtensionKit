import UIKit

public final class TransitionAnimationController: NSObject {
    public var transition: TransitionType = .push
    private var config: SharedTransitionConfig = .`default`
}

extension TransitionAnimationController: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: (any UIViewControllerContextTransitioning)?) -> TimeInterval
    {
        config.duration
    }
    
    public func animateTransition(using transitionContext: any UIViewControllerContextTransitioning)
    {
        prepareViewControllers(from: transitionContext, for: transition)
        
        switch transition {
        case .push:
            pushAnimation(with: transitionContext)
        case .pop:
            popAnimation(with: transitionContext)
        }
    }
}

public extension TransitionAnimationController {
    func pushAnimation(with context: UIViewControllerContextTransitioning) {
        guard let (fromView, fromFrame, fromSharedView,
                   toView, toFrame, toSharedView) = setup(with: context) else
        {
            context.completeTransition(false)
            return
        }

        let sharedViewTransform: CGAffineTransform = .transform(originalFrame: fromSharedView.frame,
                                                                toTargetFrame: toSharedView.frame)
        
        // Setup duplicate album art view for transitioning
        context.containerView.addSubview(fromSharedView)
        
        let fromTransform: CGAffineTransform = .init(translationX: -GlobalConstants.screenW, y: 0)
        let toTransform: CGAffineTransform = .init(translationX: GlobalConstants.screenW, y: 0)
        toView.transform = toTransform
        
        let fromPlaceholder = UIView().then {
            $0.backgroundColor = config.placeholderColor
            $0.frame = CGRect(origin: fromFrame.origin,
                              size: CGSize(width: fromFrame.width + 2,
                                           height: fromFrame.height + 2))
        }
        fromView.addSubview(fromPlaceholder)
        
        let toPlaceholder = UIView().then {
            $0.backgroundColor = config.placeholderColor
            $0.frame = toFrame
        }
        toView.addSubview(toPlaceholder)
        
        // So that fromView can fade into the background instead of black
        let backdrop = UIView().then {
            $0.backgroundColor =  .systemBackground
            $0.frame = fromView.frame
        }
        context.containerView.insertSubview(backdrop, at: 0)
        
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            usingSpringWithDamping: 2,
            initialSpringVelocity: 0.4,
            options: [])
        {
            toView.transform = .identity
            fromView.transform = fromTransform
            fromView.layer.opacity = 0
            fromSharedView.transform = sharedViewTransform
        } completion: { _ in
            fromView.transform = .identity
            fromView.layer.opacity = 1
            
            fromSharedView.removeFromSuperview()
            fromPlaceholder.removeFromSuperview()
            toPlaceholder.removeFromSuperview()
            backdrop.removeFromSuperview()
            
            context.completeTransition(true)
        }
    }
    
    func popAnimation(with context: UIViewControllerContextTransitioning) {
        guard let (fromView, fromFrame, fromSharedView,
                   toView, toFrame, toSharedView) = setup(with: context) else
        {
            context.completeTransition(false)
            return
        }
        
        let sharedViewTransform: CGAffineTransform = .transform(originalFrame: fromSharedView.frame,
                                                                toTargetFrame: toSharedView.frame)
        
        // Setup duplicate album art view for transitioning
        context.containerView.addSubview(fromSharedView)
        
        let toTransform: CGAffineTransform = .init(translationX: -GlobalConstants.screenW, y: 0)
        toView.transform = toTransform
        toView.layer.opacity = 0
        
        let fromTransform: CGAffineTransform = .init(translationX: GlobalConstants.screenW, y: 0)
        
        let fromPlaceholder = UIView().then {
            $0.backgroundColor = config.placeholderColor
            $0.frame = fromFrame
        }
        fromView.addSubview(fromPlaceholder)
        
        let toPlaceholder = UIView().then {
            $0.backgroundColor = config.placeholderColor
            $0.frame = CGRect(origin: toFrame.origin,
                              size: CGSize(width: toFrame.width + 2,
                                           height: toFrame.height + 2))
        }
        toView.addSubview(toPlaceholder)
        
        // So that toView can fade from the background instead of black for some reason
        let backdrop = UIView().then {
            $0.backgroundColor =  .systemBackground
            $0.frame = fromView.frame
        }
        context.containerView.insertSubview(backdrop, at: 0)
        
        let animation = {
            toView.layer.opacity = 1
            toView.transform = .identity
            fromView.transform = fromTransform
            fromSharedView.transform = sharedViewTransform
        }
        
        let completion = {
            fromPlaceholder.removeFromSuperview()
            toPlaceholder.removeFromSuperview()
            fromSharedView.removeFromSuperview()
            backdrop.removeFromSuperview()
            
            let isCancelled = context.transitionWasCancelled
            if isCancelled { // Reset necessary states to initial values
                fromView.transform = .identity
                toView.transform = .identity
            }
            
            context.completeTransition(!isCancelled)
        }
        
        if context.isInteractive {
            UIView.animate(duration: 0.4, curve: config.curve) { animation() } completion: { completion() }
        } else {
            UIView.animate(
                withDuration: 0.4,
                delay: 0,
                usingSpringWithDamping: 1,
                initialSpringVelocity: 0,
                options: [.beginFromCurrentState])
            {
                animation()
            } completion: { _ in
                completion()
            }
        }
    }
    
    func prepareViewControllers(from context: UIViewControllerContextTransitioning,
                                       for transition: TransitionType)
    {
        let fromVC = context.viewController(forKey: .from) as? SharedTransitioning
        let toVC = context.viewController(forKey: .to) as? SharedTransitioning
        
        if let customConfig = fromVC?.config { config = customConfig }
        
        fromVC?.prepare(for: transition)
        toVC?.prepare(for: transition)
    }
    
    func setup(with context: UIViewControllerContextTransitioning) -> (UIView, CGRect, UIView, UIView, CGRect, UIView)?
    {
        guard let toView = context.view(forKey: .to),
              let fromView = context.view(forKey: .from) else
        {
            return nil
        }
        
        if transition == .push {
            context.containerView.addSubview(toView)
        } else {
            context.containerView.insertSubview(toView, belowSubview: fromView)
        }
        
        guard let toFrame = context.sharedFrame(forKey: .to),
              let fromFrame = context.sharedFrame(forKey: .from) else
        {
            return nil
        }
        
        guard let toSharedView = context.sharedView(forKey: .to),
              let fromSharedView = context.sharedView(forKey: .from) else
        {
            return nil
        }
        
        return (fromView, fromFrame, fromSharedView, toView, toFrame, toSharedView)
    }
}
