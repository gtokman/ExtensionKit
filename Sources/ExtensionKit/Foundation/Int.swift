import Foundation

public extension Int {

    /// Whether self is an odd number
    var isOdd: Bool {
        return !isEven
    }

    /// Whether self is an even number
    var isEven: Bool {
        return self % 2 == 0
    }

    /// Treats 0 as nil
    var nilIfZero: Int? {
        if self == 0 { return nil }
        return self
    }

    /// Make the number to string
    var string: String {
        return String(self)
    }

    /// Make a range from zero to self
    var range: CountableRange<Int> {
        return 0..<self
    }

    // hours to seconds
    var hours: Int {
        return (self * 60).minutes
    }
    
    // minutes to seconds
    var minutes: Int {
        return self * 60
    }

    var days: Int {
        return (self * 24).hours
    }

    var months: Int {
        return (self * 30).days
    }

    var years: Int {
        return (self * 12).months
    }

    /// Return a number of instances
    ///
    /// - Parameter creation: The initialization of the object
    /// - Returns: An array containing the objects
    func instances<T>(of creation: @autoclosure () throws -> T) rethrows -> [T] {
        return try (0 ..< self).map { _ in
            try creation()
        }
    }

    /// Return if `self` is in the given range.
    ///
    /// - Parameter range: Target range.
    /// - Returns: `true` if self is in the range, otherwise `false`.
    func inRange(_ range: Range<Int>) -> Bool {
        return range.contains(self)
    }

    /// Calls the given block n number of times.
    func times(block: () -> Void) {
        if self <= 0 { return }
        for _ in 0..<self { block() }
    }
    
}
