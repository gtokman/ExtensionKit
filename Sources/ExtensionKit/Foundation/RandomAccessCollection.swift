import Foundation

public extension RandomAccessCollection {
    
    /// Enumerated Array of index, element pair
    /// - Returns: Array
    func indexed() -> Array<(offset: Int, element: Element)> {
        Array(enumerated())
    }
}
