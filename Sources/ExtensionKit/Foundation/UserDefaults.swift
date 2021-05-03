import Foundation

public extension UserDefaults {
    
    /// Get `Codable` model from user defaults
    /// - Parameter key: String key
    /// - Returns: Model
    func getCodable<T: Codable>(forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        let element = try? JSONDecoder().decode(T.self, from: data)
        return element
    }
    
    /// Set `Codable` mode to user defaults
    /// - Parameters:
    ///   - value: Model
    ///   - key: String key
    func setCodable<T: Codable>(value: T, forKey key: String) {
        let data = try? JSONEncoder().encode(value)
        UserDefaults.standard.setValue(data, forKey: key)
    }
    
}
