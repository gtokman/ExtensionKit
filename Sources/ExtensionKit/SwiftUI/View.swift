#if canImport(SwiftUI)

import SwiftUI

#endif

@available(iOS 13.0, *)
public extension View {

    /// Fill parent view
    /// - Parameter alignment: alignment
    /// - Returns: View with filled frame
    func fillParent(alignment: Alignment = .center) -> some View {
        self
            .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: alignment
        )
    }
    
    /// Fill parent's width
    /// - Returns: view
    func fillWidth() -> some View {
        return self.frame(minWidth: 0, maxWidth: .infinity)
    }

    /// Fill parent's height
    /// - Returns: view
    func fillHeight() -> some View {
        return self.frame(minHeight: 0, maxHeight: .infinity)
    }

    /// If a condition is true, transform and return a new view
    /// - Parameters:
    ///   - condition: condition
    ///   - transform: transformation if true
    /// - Returns: new view
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// If a condition is true, transform and return a new view
    /// - Parameters:
    ///   - condition: condition
    ///   - ifTransform: true case transform
    ///   - elseTransform: else case transform
    /// - Returns: new view
    @ViewBuilder
    func `if`<TrueContent: View, FalseContent: View>(
      _ condition: Bool,
      if ifTransform: (Self) -> TrueContent,
      else elseTransform: (Self) -> FalseContent
    ) -> some View {
      if condition {
        ifTransform(self)
      } else {
        elseTransform(self)
      }
    }
    
    /// Embed Self in `NavigationView`
    /// - Returns: New view with `NavigationView` parent
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
    
    /// Round view with specific corners
    /// - Parameters:
    ///   - radius: radius
    ///   - corners: corners to round
    /// - Returns: new rounded view
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }

    /// Debug print view representation
    /// - Returns: Self after printing
    func debug() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }

    /// Erase view to `AnyView`
    /// - Returns: new view
    func eraseToAnyView() -> AnyView{
        AnyView(self)
    }
    
    /// Hides the view conditionally
    /// - Parameter hidden: is hidden
    /// - Returns: hidden view but not drawn on screen
    @ViewBuilder
    func hidden(_ hidden: Bool) -> some View {
        switch hidden {
        case true: self.hidden()
        case false: self
        }
    }
}
