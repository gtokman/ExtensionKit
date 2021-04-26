#if canImport(SwiftUI)

import SwiftUI

#endif

public extension Text {
    
    /// Text with system font
    /// - Parameters:
    ///   - size: size, default 18
    ///   - weight: font weight, default regular
    ///   - design: font design, default .default
    /// - Returns: View
    func `default`(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .default) -> some View {
        self.font(.system(size: size, weight: weight, design: design))
    }
    
    /// Text with system font and monospaced
    /// - Parameters:
    ///   - size: size, default 18
    ///   - weight: font weight, default regular
    ///   - design: font design, default .monospaced
    /// - Returns: View
    func monospaced(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .monospaced) -> some View {
        self.font(.system(size: size, weight: weight, design: design))
    }
    
    func templateSize(for value: String) -> some View {
        return Text(value).hidden().overlay(self)
    }
    
}
