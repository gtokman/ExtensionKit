import SwiftUI

/**
 ```
 @UserDefault("key") var myInt = 0
 ```
 */
/// Save Objects in UserDefaults.standard with Property wrapper syntax
@propertyWrapper
public struct UserDefault<T> {
    
    /// Key
    public let key: String
    
    /// Get the value if it existes
    public var wrappedValue: T? {
        get { return UserDefaults.standard.object(forKey: key) as? T }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    /// Create a new Default with Key
    /// - Parameter key: String key
    public init(_ key: String) { self.key = key }
}
