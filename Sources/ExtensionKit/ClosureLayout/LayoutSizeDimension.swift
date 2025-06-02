import UIKit

public protocol LayoutSizeDimension {
    func constraint(equalToConstant c: CGSize) -> (height: NSLayoutConstraint, width: NSLayoutConstraint)
}

public struct LayoutSizeDimensionAnchor: LayoutSizeDimension {
    let heightAnchor: NSLayoutDimension
    let widthAnchor: NSLayoutDimension
    
    public func constraint(
        equalToConstant c: CGSize
    ) -> (
        height: NSLayoutConstraint,
        width: NSLayoutConstraint
    ) {
        return (
            height: heightAnchor.constraint(equalToConstant: c.height),
            width: widthAnchor.constraint(equalToConstant: c.width)
        )
    }
}
