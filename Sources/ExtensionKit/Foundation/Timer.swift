import Foundation

public extension Timer {
    
    /// Schedule closure to run on main run loop after delay
    ///
    /// - Parameters:
    ///   - delay: Delay interval
    ///   - handler: Closure to run
    /// - Returns: `CFRunLoopTimer`
    @discardableResult
    class func schedule(delay: TimeInterval, handler: @escaping () -> Void) -> CFRunLoopTimer? {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0) { _ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
    
    ///  Schedule closure to run on main run loop and repeat at the interval
    ///
    /// - Parameters:
    ///   - interval: 触发时长，从现在开始经过interval时长后触发第一次
    ///   - handler: Closure to run
    /// - Returns: CFRunLoopTimer
    @discardableResult
    class func schedule(repeatInterval interval: TimeInterval, handler: @escaping () -> Void) -> CFRunLoopTimer? {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0) { _ in
            handler()
        }
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer
    }
    
}
