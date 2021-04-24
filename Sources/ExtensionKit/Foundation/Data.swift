import Foundation

public extension Data {
    /// Returns a string of hex value.
    var hexString: String {
        return withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> String in
            let buffer = bytes.bindMemory(to: UInt8.self)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}
