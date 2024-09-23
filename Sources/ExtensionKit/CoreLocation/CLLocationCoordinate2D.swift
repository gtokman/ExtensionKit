import CoreLocation

extension CLLocationCoordinate2D: @retroactive Equatable {
    
    /// Equatable coordinates
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
    
}

extension CLLocationCoordinate2D: Codable {
    
    /// `CLLocationCoordinate2D` at (latitude: 0, longitude 0)
    public static let zero = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    /// Encode a `CLLocationCoordinate2D`
    /// - Parameter encoder: Encoder
    /// - Throws: `EncodingError`
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(longitude)
        try container.encode(latitude)
    }

    /// Decode `CLLocationCoordinate2D` from data
    /// - Parameter decoder: Decoder
    /// - Throws: `DecodingError`
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let longitude = try container.decode(CLLocationDegrees.self)
        let latitude = try container.decode(CLLocationDegrees.self)
        self.init(latitude: latitude, longitude: longitude)
    }
}
