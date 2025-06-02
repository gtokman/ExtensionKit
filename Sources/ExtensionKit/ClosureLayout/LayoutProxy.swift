import UIKit

public class LayoutProxy {
    public lazy var leading = LayoutProperty(anchor: view.leadingAnchor)
    public lazy var trailing = LayoutProperty(anchor: view.trailingAnchor)
    public lazy var top = LayoutProperty(anchor: view.topAnchor)
    public lazy var bottom = LayoutProperty(anchor: view.bottomAnchor)
    public lazy var width = LayoutProperty(anchor: view.widthAnchor)
    public lazy var height = LayoutProperty(anchor: view.heightAnchor)
    public lazy var centerX = LayoutProperty(anchor: view.centerXAnchor)
    public lazy var centerY = LayoutProperty(anchor: view.centerYAnchor)
    public lazy var size = LayoutProperty(
        anchor: LayoutSizeDimensionAnchor(
            heightAnchor: view.heightAnchor,
            widthAnchor: view.widthAnchor
        )
    )
    
    private let view: UIView

    init(view: UIView) {
        self.view = view
    }
}
