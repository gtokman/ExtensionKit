import Combine
import CoreLocation

public extension CLLocationManager {
    
    /*
     /// Upgrade the user authoriztion status
     requestLocationAuthorization()
     .flatMap { status -> AnyPublisher<CLAuthorizationStatus, Never> in
         if status == CLAuthorizationStatus.authorizedAlways {
             return AuthorizationPublisher(manager: manager, authorizationType: type)
                 .eraseToAnyPublisher()
         } else {
             return Just(status)
                 .eraseToAnyPublisher()
         }
     }
     **/
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    static func requestLocationAuthorization(
        with manager: CLLocationManager = .init(),
        type: AuthorizationType
    ) -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: manager, authorizationType: type)
            .eraseToAnyPublisher()
    }
    
    /// Receive location updates from the `CLLocationManager`
    /// - Parameter manager: `CLLocationManager`
    /// - Returns: Publisher with `[CLLocation]` or `Error`
    static func receiveLocationUpdates(
        from manager: CLLocationManager = .init()
    ) -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: manager)
            .eraseToAnyPublisher()
    }

    /// Authorization access level
    enum AuthorizationType: String {
        case always, whenInUse
    }

}
