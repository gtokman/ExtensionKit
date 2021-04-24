import Foundation

public extension CFRunLoopTimer {
    
    /// Invalidate CFRunLoopTimer
    func invalidate() {
        CFRunLoopRemoveTimer(CFRunLoopGetCurrent(), self, .commonModes)
    }
    
}
