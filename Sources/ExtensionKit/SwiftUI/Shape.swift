import SwiftUI

@available(iOS 13.0, OSX 10.15, *)
public extension Shape {
    
    /// Addd a `LinearGradient` fill on Shape
    /// - Parameters:
    ///   - colors: Colors
    ///   - start: Start, default top
    ///   - end: End, default bottom
    /// - Returns: View
    func gradientFill(
        colors: Color...,
        start: UnitPoint = .top,
        end: UnitPoint = .bottom) -> some View {
            fill(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: start, endPoint: end)
            )
    }
}
