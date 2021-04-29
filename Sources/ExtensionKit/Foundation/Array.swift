import Foundation

public extension Array where Element: Equatable {
    
    /// Removes the given element in the array.
    ///
    /// - Parameter element: The element to be removed.
    /// - Returns: The element got removed, or `nil` if the element doesn't exist.
    @discardableResult
    mutating func remove(_ element: Element) -> Element? {
        if let index = self.firstIndex(of: element) {
            return self.remove(at: index)
        }
        return nil
    }
    
    /// Returns an array where repeating elements of the receiver got removed.
    var removingRepeatElements: Array<Element> {
        var arr = Array<Element>()
        forEach {
            if !arr.contains($0) {
                arr.append($0)
            }
        }
        return arr
    }
}


public extension Array where Element == URLQueryItem {
    
    /// Initialize `URLQueryItem from dictionary`
    /// - Parameter dictionary: url parameters
    init<T: LosslessStringConvertible>(_ dictionary: [String: T]) {
        self = dictionary.map { (key, value) -> Element in
            .init(name: key, value: String(value))
        }
    }
    
}
