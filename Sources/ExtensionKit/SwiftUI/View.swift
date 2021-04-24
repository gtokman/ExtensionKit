import SwiftUI

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

}
