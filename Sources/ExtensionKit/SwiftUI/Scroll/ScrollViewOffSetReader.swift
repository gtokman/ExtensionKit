import SwiftUI
import UIKit

/// Hosting controller that updates the scroll view offset (x,y)
class ScrollViewOffSetReader<Content>: UIHostingController<Content> where Content: View {
    
    var offset: Binding<CGPoint>
    let isOffsetX: Bool
    var showed = false
    var sv: UIScrollView?

    init(offset: Binding<CGPoint>, isOffsetX: Bool, rootView: Content) {
        self.offset = offset
        self.isOffsetX = isOffsetX
        super.init(rootView: rootView)
    }

    @objc dynamic required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        if showed {
            return
        }
        showed = true

        sv = findScrollView(in: view)

        sv?.addObserver(self,
                        forKeyPath: #keyPath(UIScrollView.contentOffset),
                        options: [.old, .new],
                        context: nil)

        scroll(to: offset.wrappedValue, animated: false
        )

        super.viewDidAppear(animated)
    }

    func scroll(to offset: CGPoint, animated: Bool = true) {
        if let s = sv {
            if offset != self.offset.wrappedValue {
                let offset = self.isOffsetX
                    ? CGPoint(x: offset.x, y: 0)
                    : CGPoint(x: 0, y: offset.y)
                s.setContentOffset(offset, animated: animated)
            }
        }
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(UIScrollView.contentOffset) {
            if let s = self.sv {
                DispatchQueue.main.async {
                    self.offset.wrappedValue = s.contentOffset
                }
            }
        }
    }

    func findScrollView(in view: UIView?) -> UIScrollView? {
        if view?.isKind(of: UIScrollView.self) ?? false {
            return view as? UIScrollView
        }

        for subview in view?.subviews ?? [] {
            if let sv = findScrollView(in: subview) {
                return sv
            }
        }

        return nil
    }
}

struct ScrollViewOffSetReaderRepresentable<Content>: UIViewControllerRepresentable where Content: View {
    
    var offset: Binding<CGPoint>
    let isOffsetX: Bool
    let content: Content

    init(offset: Binding<CGPoint>, isOffsetX: Bool, @ViewBuilder content: @escaping () -> Content) {

        self.offset = offset
        self.isOffsetX = isOffsetX
        self.content = content()
    }

    func makeUIViewController(context: Context) -> ScrollViewOffSetReader<Content> {
        ScrollViewOffSetReader(offset: offset, isOffsetX: isOffsetX, rootView: content)
    }

    func updateUIViewController(_ uiViewController: ScrollViewOffSetReader<Content>, context: Context) {
        uiViewController.scroll(to: offset.wrappedValue, animated: true)
    }
}
