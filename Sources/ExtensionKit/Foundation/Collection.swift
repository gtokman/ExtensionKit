import Foundation

public extension Collection {
    
    /// Safe indexing.
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    /// ref: https://stackoverflow.com/questions/25329186/safe-bounds-checked-array-lookup-in-swift-through-optional-bindings
    ///
    /// - Parameter index: The index used to retrieve a value / an object.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
    /// Distance to index
    /// - Parameter index: Index
    /// - Returns: Int
    func distance(to index: Index) -> Int {
        return self.distance(from: startIndex, to: index)
    }
}
