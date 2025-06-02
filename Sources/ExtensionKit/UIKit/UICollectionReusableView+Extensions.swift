import UIKit

public extension UICollectionReusableView {
    /// Gives each cell an identifier that is derived from its `String(describing: self)`
    /// 
    static var identifier: String {
        return String(describing: self)
    }
}
