import Foundation

/// AppVersion set in `CFBundleShortVersionString`
public var appVersion: String {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
}

/// Languages set in user defaults key `AppleLanguages`
public var systemLanguages: [String] {
    return UserDefaults.standard.stringArray(forKey: "AppleLanguages") ?? []
}

/// Sleeps the thread
/// - Parameter duration: in seconds
public func sleep(duration: TimeInterval) {
    #if DEBUG
        Thread.sleep(forTimeInterval: duration)
    #endif
}

/// Swift still calls `print()` and/or `debugPrint()` in shipped apps.
/// We use a method described in onevcat's post (https://onevcat.com/2016/02/swift-performance/)
/// to optimaze the performance.
///
/// - Parameter item: items to print
public func dprint(_ item: @autoclosure () -> Any) {
    #if DEBUG
        print(item())
    #endif
}
