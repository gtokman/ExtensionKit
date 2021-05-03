#if canImport(UIKit)

import UIKit
import SafariServices

#endif

public extension UIViewController {
    
    /// ViewController class name
    var classNameValue: String { NSStringFromClass(self.classForCoder).components(separatedBy: ".").last! }
    
    /// Adds a child viewController to the current controller view
    /// - Parameter viewController: The child view
    func addChild(viewController: UIViewController, in view: UIView) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    /// Removes a child viewController from current
    /// - Parameter viewController: The child view controller to remove
    func removeChild(viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

    /// Combine an array of models and an array of views.
    ///
    /// - Parameters:
    ///   - models: The models as data source.
    ///   - views: The views in need of loading data. Note that this is an inout parameters.
    ///   - newViewGeneration: The function to generate new views, which would immediately be appended into `views`.
    ///   - operation: The main operation that combine each model and view together.
    ///   - remainingViews: The handler responsible for dealing with the rest of unused views.
    class func combine<Model, View>(models: [Model], into views: inout [View], newViewGeneration: () -> View, using operation: (Model, View) -> Void, remainingViews: (ArraySlice<View>) -> Void) {

        // If the models outnumber the views, generate more views
        if models.count > views.count {
            for _ in 0 ..< models.count - views.count {
                views.append(newViewGeneration())
            }
        }

        // Combine each model into each view
        for i in 0 ..< models.count {
            operation(models[i], views[i])
        }

        // Handle the rest of unused views
        if views.count > models.count {
            remainingViews(views.suffix(from: models.count))
        }
    }

    /// Present system alert
    ///
    /// - Parameters:
    ///   - title: Title
    ///   - message: Message
    ///   - confirmTitle: Confirm button title
    ///   - confirmHandler: Confirm handler to run on press
    ///   - cancelTitle: Cancel button title
    ///   - cancelHandler: Cancel handler to run on press
    func showSystemAlert(
        title: String?,
        message: String? = nil,
        confirmTitle: String? = nil,
        confirmHandler: (() -> Void)? = nil,
        cancelTitle: String = "Cancel",
        cancelHandler: (() -> Void)? = nil)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(
            title: cancelTitle,
            style: .cancel,
            handler: { _ in cancelHandler?() }
        )
        alertController.addAction(cancelAction)

        if let confirmTitle = confirmTitle {
            let confirmAction = UIAlertAction(
                title: confirmTitle,
                style: .default,
                handler: { _ in confirmHandler?() }
            )
            alertController.addAction(confirmAction)
        }

        present(alertController, animated: true, completion: nil)
    }

    /// Present system alert with distructive primary action
    ///
    /// - Parameters:
    ///   - title: Title
    ///   - message: Message
    ///   - confirmTitle: Confirm button title
    ///   - confirmHandler: Confirm handler to run on press
    ///   - cancelTitle: Cancel button title
    ///   - cancelHandler: Cancel handler to run on press
    func showSystemDistructiveAlert(
        title: String?,
        message: String? = nil,
        destructiveTitle: String?,
        destructiveHandler: (() -> Void)?,
        cancelTitle: String?,
        cancelHandler: (() -> Void)? = nil)
    {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertViewController.addAction(UIAlertAction(
            title: cancelTitle,
            style: .cancel,
            handler: { _ in
                cancelHandler?()
            }))
        alertViewController.addAction(UIAlertAction(
            title: destructiveTitle,
            style: .destructive,
            handler: { _ in
                destructiveHandler?()
            }))
        present(alertViewController, animated: true, completion: nil)
    }


    /// Present action sheet
    ///
    /// - Parameters:
    ///   - title: Title
    ///   - message: Message
    ///   - actions: Actions in the sheet
    func showSystemActionSheet(title: String?, message: String?, validActions: (String?, (() -> Void)?)...) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        validActions.forEach { action in
            ac.addAction(UIAlertAction(
                title: action.0,
                style: .default,
                handler: { _ in
                    action.1?()
                }))
        }
        ac.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil))
        present(ac, animated: true, completion: nil)
    }


    /// NavigationBar tint color
    var titleColor: UIColor? {
        get {
            return navigationController?.navigationBar.titleTextAttributes?[.foregroundColor] as? UIColor
        }
        set {
            if navigationController?.navigationBar.titleTextAttributes == nil {
                navigationController?.navigationBar.titleTextAttributes = [:]
            }
            navigationController?.navigationBar.titleTextAttributes?[.foregroundColor] = newValue
        }
    }


    /// NavigationBar font
    var titleFont: UIFont? {
        get {
            return navigationController?.navigationBar.titleTextAttributes?[.font] as? UIFont
        }
        set {
            if navigationController?.navigationBar.titleTextAttributes == nil {
                navigationController?.navigationBar.titleTextAttributes = [:]
            }
            navigationController?.navigationBar.titleTextAttributes?[.font] = newValue
        }
    }

    /// Is view loaded and in window
    var viewIsVisible: Bool {
        return (isViewLoaded && view.window != nil)
    }

    private struct AutoHideKeyboardTapKey {
        static var key = "autoHideKeyboardTap"
    }

    /// Should hide keyboard on view tap
    var automaticallyHideKeyboardWhenViewTapped: Bool {
        get {
            return objc_getAssociatedObject(self, &AutoHideKeyboardTapKey.key) != nil
        }
        set {
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.resignTextFieldToHideKeyboard(_:)))
            view.addGestureRecognizer(tap)
            objc_setAssociatedObject(self, &AutoHideKeyboardTapKey.key, tap, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        }
    }
    
    /// Resign keyboard
    @IBAction func resignTextFieldToHideKeyboard(_ sender: AnyObject) {
        view.endEditing(false)
    }

    /// Get the current visible view controller by crawling the view controller heirarchy
    ///
    /// - Parameter base: `UIViewController` to search
    /// - Returns: Current `UIViewController`
    class func getCurrentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return getCurrentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }

    /// Add a bottom tool bar to view controller
    var bottomToolBar: UIView? {
        get {
            if let toolbarItems = toolbarItems, toolbarItems.count == 3 {
                return toolbarItems[1].customView
            }
            return nil
        }
        set {
            if let bar = newValue {
                let toolbarItems = [
                    UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
                    UIBarButtonItem(customView: bar),
                    UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                ]
                setToolbarItems(toolbarItems, animated: false)
            } else {
                setToolbarItems(nil, animated: false)
            }
        }
    }

    /// Pop view controller from nav stack
    func popFromNavigationStack() {
        navigationController?.popViewController(animated: true)
    }

    /// Add dismiss `UIBarButtonItem` naviation item
    func addDismissNavigationItem(localizedTitle: String = "Dismiss", image: UIImage? = nil) {
        if let image = image {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(dismissSelf(_:)))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: localizedTitle, style: .plain, target: self, action: #selector(dismissSelf(_:)))
        }
    }

    @objc func dismissSelf(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    private struct HidesNavigationBarBackgroundKey {
        static var whenVisible = "hidesNavigationBarBackgroundWhenVisible"
    }

    /// Hide navigation bar background when visible
    var hidesNavigationBarBackgroundWhenVisible: Bool {
        get {
            return (objc_getAssociatedObject(self, &HidesNavigationBarBackgroundKey.whenVisible) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &HidesNavigationBarBackgroundKey.whenVisible, true, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }

    /// Navigation bar height
    var navigationBarHeight: CGFloat {
        return navigationController?.navigationBar.bounds.height ?? 0
    }

    /// Tab bar height
    var tabBarHeight: CGFloat {
        return tabBarController?.tabBar.bounds.height ?? 0
    }

    func pushSafariViewController(urlString: String, entersReaderIfAvailable: Bool = false) {
        if let url = URL(string: urlString) {
            let safariViewController: SFSafariViewController = {
                if #available(iOS 11.0, *) {
                    let configuration = SFSafariViewController.Configuration()
                    configuration.entersReaderIfAvailable = entersReaderIfAvailable
                    return SFSafariViewController(url: url, configuration: configuration)
                } else {
                    return SFSafariViewController(url: url)
                }
            }()
            if #available(iOS 11.0, *) {
                safariViewController.dismissButtonStyle = .close
                safariViewController.configuration.entersReaderIfAvailable = true
            }
            present(safariViewController, animated: true, completion: nil)
        }
    }
}
