import UIKit

/// Wrapper to access main screen size
public struct Screen {
    
    /// Main screen width
    public static let width = UIScreen.main.bounds.width
    
    /// Main screen height
    public static let height = UIScreen.main.bounds.height
    
    /// Main screen bounds
    public static let bounds = UIScreen.main.bounds
    
    /// Main screen origin
    public static let origin = UIScreen.main.bounds.origin
}
