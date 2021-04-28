import SwiftUI

public extension Button where Label == Image {
    
    /// Initialize button with system image and trailing action
    /// - Parameters:
    ///   - systemName: System image name
    ///   - action: action
    init(systemName: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(systemName: systemName)
        }
    }
    
    /// Initialize button with local image and trailing action
    /// - Parameters:
    ///   - systemName: System image name
    ///   - action: action
    init(imageName: String, action: @escaping () -> Void) {
        self.init(action: action) {
            Image(imageName)
        }
    }
}
