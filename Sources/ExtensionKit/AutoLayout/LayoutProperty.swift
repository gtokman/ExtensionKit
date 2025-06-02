import UIKit

public struct LayoutProperty<Anchor> {
    let anchor: Anchor
}

extension LayoutProperty where Anchor: LayoutAnchor {
    func equal(to otherAnchor: Anchor, offsetBy
               constant: CGFloat = 0)
    {
        anchor.constraint(equalTo: otherAnchor,
                          constant: constant).isActive = true
    }
    
    func greaterThanOrEqual(to otherAnchor: Anchor,
                            offsetBy constant: CGFloat = 0)
    {
        anchor.constraint(greaterThanOrEqualTo: otherAnchor,
                          constant: constant).isActive = true
    }
    
    func lessThanOrEqual(to otherAnchor: Anchor,
                         offsetBy constant: CGFloat = 0)
    {
        anchor.constraint(lessThanOrEqualTo: otherAnchor,
                          constant: constant).isActive = true
    }
}

extension LayoutProperty where Anchor: LayoutDimension {
    func equalToConstant(_ c: CGFloat) {
        anchor.constraint(equalToConstant: c).isActive = true
    }
    
    func lessThanOrEqualToConstant(_ c: CGFloat) {
        anchor.constraint(lessThanOrEqualToConstant: c).isActive = true
    }
    
    func greaterThanOrEqualToConstant(_ c: CGFloat) {
        anchor.constraint(greaterThanOrEqualToConstant: c).isActive = true
    }
}

extension LayoutProperty where Anchor: LayoutSizeDimension {
    func equalToConstant(_ c: CGSize) {
        let constraints = anchor.constraint(equalToConstant: c)
        constraints.height.isActive = true
        constraints.width.isActive = true
    }
}
