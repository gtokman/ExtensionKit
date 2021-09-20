import CoreLocation
import Combine

public extension CLLocation {

    /// `CLLocation` from `CLLocationCoordinate2D`
    /// - Parameter coordinate: `CLLocationCoordinate2D`
    convenience init(from coordinate: CLLocationCoordinate2D) {
        self.init(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    /// Geocode location `Error`
    enum GeocodeError: Error {
        case invalid(String)
        case empty(String)
    }

    /// Reverse geocode a `CLLocation`
    /// - Parameter location: `CLLocation`
    /// - Returns: Future with Result<[`CLPlacemark`], `GeocodeError`>
    func reverseGeocode() -> Deferred<Future<[CLPlacemark], GeocodeError>> {
        Deferred {
            Future { promise in
                CLGeocoder().reverseGeocodeLocation(self) { placemarks, error -> Void in
                    if let err = error {
                        return promise(.failure(.invalid("\(String(describing: err))")))
                    }
                    guard let marks = placemarks, !marks.isEmpty else {
                        return promise(.failure(.empty("\(String(describing: placemarks))")))
                    }
                    return promise(.success(marks))
                }
            }
        }
    }
}
