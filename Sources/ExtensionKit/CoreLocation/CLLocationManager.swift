import Combine
import CoreLocation

public extension CLLocationManager {
    
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    static func requestLocationAuthorization(
        with manager: CLLocationManager
        type: AuthorizationType
    ) -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: manager, authorizationType: type)
            .eraseToAnyPublisher()
    }
    
    /// Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    /// - Returns: Publisher with `AuthorizationType`
    static func requestLocationAlwaysAuthorization(
        with manager: CLLocationManager
    ) -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: manager, authorizationType: .always)
            .flatMap { status -> AnyPublisher<CLAuthorizationStatus, Never> in
                if status == CLAuthorizationStatus.authorizedAlways {
                    return AuthorizationPublisher(
                        manager: manager,
                        authorizationType: .always
                    )
                    .eraseToAnyPublisher()
                }
                return Just(status).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

    /// Receive location updates from the `CLLocationManager`
    /// - Parameter manager: `CLLocationManager`
    /// - Returns: Publisher with `[CLLocation]` or `Error`
    static func receiveLocationUpdates(
        from manager: CLLocationManager
    ) -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: manager)
            .eraseToAnyPublisher()
    }

    /// Authorization access level
    enum AuthorizationType: String {
        case always, whenInUse
    }

}
