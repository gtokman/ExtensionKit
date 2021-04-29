import Foundation

public extension URL {
    
    /// Create URL from String
    /// - Parameter string: URL string
    init(_ string: StaticString) {
        self.init(string: "\(string)")!
    }

    /// Create URL from baseUrl, path, and parameters
    /// - Parameters:
    ///   - baseUrl: base URL including the host (https)
    ///   - path: url path default, empty string
    ///   - parameters: parameters, key/value pair
    init?<T: LosslessStringConvertible>(
        _ baseUrl: StaticString,
        path: StaticString = "",
        parameters: [String: T] = [:]
    ) {
        var urlComponents = URLComponents(string: "\(baseUrl)")
        urlComponents?.path = "\(path)"
        urlComponents?.queryItems = .init(parameters)
        guard let url = urlComponents?.url else {
            dprint("ERROR: Could not create URL from \(baseUrl) + \(path) + \(parameters)")
            return nil
        }
        self = url
    }
}
