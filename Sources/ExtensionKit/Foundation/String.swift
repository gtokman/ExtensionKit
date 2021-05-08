#if canImport(UIKit)

import UIKit

#endif

internal extension StaticString {
    var toString: String {
        "\(self)"
    }
}

public extension String {
    
    subscript(_ i: Int) -> String {
        let idx1 = index(startIndex, offsetBy: i)
        let idx2 = index(idx1, offsetBy: 1)
        return String(self[idx1..<idx2])
    }

    subscript(r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start ..< end])
    }

    subscript(r: CountableClosedRange<Int>) -> String {
        let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
        let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return String(self[startIndex...endIndex])
    }
    
    /// Remove HTML tags from String
    var removeHTML: String {
        return self.replacingOccurrences(
            of: "<[^>]+>", with: "", options: .regularExpression, range: nil
        )
    }
    
    /// Is valid email
    var isEmail: Bool {
        let emailRegax = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegax)
        return emailTest.evaluate(with: self)
    }

    /// Are numbers 0-9
    var areNumbers: Bool {
        let allnumRegex = "^[0-9]*$"
        let numPredicate = NSPredicate(format: "SELF MATCHES %@", allnumRegex)
        return numPredicate.evaluate(with: self)
    }
    
    /// Cast to Int
    var toInt: Int? { Int(self) }
    
    /// Cast to Double
    var toDouble: Double? { Double(self) }
    
    /// Trimming ".0"
    var trimmingZeroDecimal: String {
        if let double = Double(self), double.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", double)
        }
        return self
    }
    
    /// Trim white space and new lines
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    /// Adding "+" at the very beginning.
    var addingPlusSymbol: String { "+" + self }
    
    /// Adding "-" at the very beginning.
    var addingMinusSymbol: String { "-" + self }
    
    /// Returns the CGSize that the string being layout on screen.
    ///
    /// - Parameter font: The given font.
    /// - Returns: The result CGSize.
    func layoutSize(with font: UIFont) -> CGSize {
        self.size(withAttributes: [.font: font])
    }

    /// Cast as Int and add the given value. No changes if casting fails.
    mutating func advanceNumberValue(step: Int = 1) {
        if let value = Int(self) {
            self = String(value.advanced(by: step))
        }
    }
    
    /// Comparing app versions. Returns `true` if self is `1.1.0` and the given value is `1.2.0`.
    /// - Parameter aVersion: Another version.
    /// - Returns: `true`  if the give version is newer than self.
    func isOldAppVersion(comparedWith aVersion: String) -> Bool {
        self.compare(aVersion, options: .numeric) == .orderedAscending
    }
    
    var uppercasingFirstLetter: String {
        prefix(1).uppercased() + dropFirst()
    }
    
    var lowercasingFirstLetter: String {
        prefix(1).lowercased() + dropFirst()
    }
    
    /// Return `true` if self is empty or only contains white spaces and/or new lines.
    var isBlank: Bool { isEmpty || trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
    
    /// Return `false` if self is empty or only contains white spaces and/or new lines.
    var isVisible: Bool { !isBlank }
    
    /// Return `nil` if `self.isBlank` is `true`.
    var nilIfBlank: String? { isBlank ? nil : self }
    
    @available(*, deprecated, message: "Use `nilIfBlank` instead.")
    func treatsVisuallyEmptyAsNil() -> String? { nilIfBlank }
    
    /// Get subscring from created range
    /// - Parameters:
    ///   - from: from String
    ///   - to: to String
    /// - Returns: String
    func slice(from: String, to: String) -> String? {
        if let r1 = self.range(of: from)?.upperBound, let r2 = self.range(of: to)?.lowerBound {
            return (String(self[r1..<r2]))
        }
        return nil
    }
    
    /// Copy self to UIPasteboard
    func copyToPasteboard() {
        UIPasteboard.general.string = self
    }
}

public extension String.Index {
    
    /// Distance to String value
    /// - Parameter string: String distance too
    /// - Returns: Int
    func distance<S: StringProtocol>(in string: S) -> Int { return string.distance(to: self) }
}
