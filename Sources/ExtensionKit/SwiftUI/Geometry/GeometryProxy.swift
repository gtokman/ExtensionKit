import SwiftUI

@available(iOS 13.0, OSX 10.15, *)
public extension GeometryProxy {
    
    /// Returns the width minus the safeAreaInsets.
    var safeWidth: CGFloat {
        size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
    
    /// Returns the height minus the safeAreaInsets.
    var safeHeight: CGFloat {
        size.height - safeAreaInsets.top - safeAreaInsets.bottom
    }
    
    var localFrame: CGRect { frame(in: .local) }
    
    var localWidth: CGFloat { localFrame.width }
    
    var localHeight: CGFloat { localFrame.height }
    
    var localCenter: CGPoint { .init(x: localFrame.midX, y: localFrame.midY) }
    
    var localTop: CGFloat { localFrame.minY }
    
    var localBottom: CGFloat { localFrame.maxY }
    
    var localLeft: CGFloat { localFrame.minX }
    
    var localRight: CGFloat { localFrame.maxX }
    
    var localDiameter: CGFloat { return min(localWidth, localHeight) }
    
    var globalFrame: CGRect { frame(in: .global) }
    
    var globalWidth: CGFloat { globalFrame.width }
    
    var globalHeight: CGFloat { globalFrame.height }
    
    var globalCenter: CGPoint { .init(x: globalFrame.midX, y: globalFrame.midY) }
    
    var globalTop: CGFloat { globalFrame.minY }
    
    var globalBottom: CGFloat { globalFrame.maxY }
    
    var globalLeft: CGFloat { globalFrame.minX }
    
    var globalRight: CGFloat { globalFrame.maxX }
    
    var globalDiameter: CGFloat { return min(globalWidth, globalHeight) }
}
