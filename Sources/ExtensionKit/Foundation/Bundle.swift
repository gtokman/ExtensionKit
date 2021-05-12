import Foundation
import Combine

public extension Bundle {
    
    /// Version number via -  CFBundleShortVersionString
    var versionNumber: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    /// Build number via -  CFBundleVersion
    var buildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    internal enum DataDecodingError: Error {
        case urlNotFound(String)
        case contentsOfURL(String)
    }

    /// Load model type from bundle resource
    /// - Parameters:
    ///   - type: Type to load
    ///   - file: File name
    ///   - dateDecodingStrategy: date decoding strategy
    ///   - keyDecodingStrategy: key decoding strategy
    /// - Returns: Future
    func decode<T: Decodable>(
        _ type: T.Type,
        fromFile file: String,
        withExtension `extension`: String? = nil,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
    ) -> Deferred<Future<T, Error>> {
        Deferred {
            Future { promise in
                guard let url = self.url(forResource: file, withExtension: `extension`) else {
                    promise(.failure(DataDecodingError.urlNotFound("Failed to locate \(file) in bundle.")))
                    return
                }

                guard let data = try? Data(contentsOf: url) else {
                    promise(.failure(DataDecodingError.contentsOfURL("Failed to load \(file) in bundle.")))
                    return
                }

                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                decoder.keyDecodingStrategy = keyDecodingStrategy

                do {
                    let type = try decoder.decode(T.self, from: data)
                    promise(.success(type))
                } catch {
                    promise(.failure(error))
                }
                
            }
        }
    }
    
}
