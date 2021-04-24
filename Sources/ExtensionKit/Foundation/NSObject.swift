import Foundation

public extension NSObject {
    
    /// Exchange two implementations of the given selectors, aka method swizzling.
    ///
    /// - Parameters:
    ///   - originalSelector: The original selector.
    ///   - swizzledSelector: Another selector.
    class func exchangeImplementations(originalSelector: Selector, swizzledSelector: Selector) {
        guard
            let originalMethod = class_getInstanceMethod(self, originalSelector),
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
        else {
            dprint("Error: Unable to exchange method implemenation!!")
            return
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    /// Return class name.
    var className: String {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }
    
    /// Print the deinitialization message of self.
    final func printDeinitMessage() {
        dprint("Deinit Message: \(className): \(self)")
    }
    
}
