import SwiftUI

public extension Text {
    
    /// Dateformatter
    static let dateFormatter = DateFormatter()
    
    /// Create Text from date formate
    /// - Parameters:
    ///   - date: `Date`
    ///   - dateStyle: `DateFormatter.Style`, default .full
    init(_ date: Date, dateStyle: DateFormatter.Style = .full) {
        let formatter = Text.dateFormatter
        formatter.dateStyle = dateStyle
        self.init(verbatim: formatter.string(from: date))
    }

    /// Create Text with date formatter string
    /// - Parameters:
    ///   - date: `Date`
    ///   - formatter: `DateFormatter`
    init(_ date: Date, formatter: DateFormatter = Text.dateFormatter) {
      self.init(verbatim: formatter.string(from: date))
    }
    
    /// Text with system font
    /// - Parameters:
    ///   - size: size, default 18
    ///   - weight: font weight, default regular
    ///   - design: font design, default .default
    /// - Returns: View
    func system(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .default) -> Text {
        self.font(.system(size: size, weight: weight, design: design))
    }
    
    /// Text with system font and monospaced
    /// - Parameters:
    ///   - size: size, default 18
    ///   - weight: font weight, default regular
    ///   - design: font design, default .monospaced
    /// - Returns: View
    func monospaced(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .monospaced) -> Text {
        self.font(.system(size: size, weight: weight, design: design))
    }

    /// Hidden `View` with frame of String vale
    /// - Parameter value: String
    /// - Returns: View
    func templateSize(for value: String) -> some View {
        return Text(value).hidden().overlay(self)
    }
    
}
