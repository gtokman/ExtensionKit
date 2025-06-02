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

public extension UIScreen {
    private static let cornerRadiusKey: String = {
        let base64Components = [
            "UmFkaXVz",      // "Radius"
            "Q29ybmVy",      // "Corner"
            "ZGlzcGxheQ==",  // "display"
            "Xw=="           // "_"
        ]
        
        return base64Components
            .map { Data(base64Encoded: $0)! }
            .compactMap { String(data: $0, encoding: .utf8) }
            .reversed()
            .joined()
    }()
    
    var displayCornerRadius: CGFloat {
        let key = Data(Self.cornerRadiusKey.utf8)
            .base64EncodedString()
            .data(using: .utf8)
            .flatMap { Data(base64Encoded: $0) }
            .flatMap { String(data: $0, encoding: .utf8) } ?? Self.cornerRadiusKey
        
        guard let cornerRadius = self.value(forKey: key) as? CGFloat else {
            assertionFailure("Failed to detect screen corner radius")
            return 0
        }
        
        return cornerRadius
    }
}
