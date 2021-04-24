import CoreGraphics

public extension CGPoint {
    
    /// Offset point by new x and y
    /// - Parameters:
    ///   - x: x
    ///   - y: y
    /// - Returns: new point
    func offseted(x: CGFloat = 0.0, y: CGFloat = 0.0) -> CGPoint {
        var point = self
        point.x += x
        point.y += y
        return point
    }
}
