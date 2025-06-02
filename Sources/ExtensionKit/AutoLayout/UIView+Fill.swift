import UIKit

extension UIView {
    @discardableResult
    public func fillWith(
        _ view: UIView,
        insets: UIEdgeInsets? = nil
    ) -> (
        top: NSLayoutConstraint,
        bottom: NSLayoutConstraint,
        leading: NSLayoutConstraint,
        trailing: NSLayoutConstraint
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        
        let topInset = insets?.top ?? 0
        let bottomInset = -(insets?.bottom ?? 0)
        let leadingInset = insets?.left ?? 0
        let trailingInset = -(insets?.right ?? 0)
        
        let top = view.topAnchor.constraint(equalTo: topAnchor, constant: topInset)
        let bottom = view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomInset)
        let leading = view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingInset)
        let trailing = view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingInset)
        
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
        
        return (top: top, bottom: bottom, leading: leading, trailing: trailing)
    }
}
