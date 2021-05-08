import Foundation

extension DispatchQueue {
    
    /// Run closure if thread is main else switch to main and run the closure
    /// - Parameter work: Closure to run
    static func mainSafeAsync(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            main.async(execute: work)
        }
    }
}
