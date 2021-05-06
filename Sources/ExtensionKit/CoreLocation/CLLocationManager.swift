import Combine
import CoreLocation

public extension CLLocationManager {
    
    /*
     ```
     class LocationStore: ObservableObject {
         
         @Published var coordinate: CLLocationCoordinate2D = .zero
         @Published var status: CLAuthorizationStatus = .notDetermined
         
         let manager = CLLocationManager()
         
         var cancellables = Set<AnyCancellable>()
         
         func requestPermission() {
             CLLocationManager
                 .requestLocationAuthorization(with: manager, type: .whenInUse)
                 .assign(to: \.status, on: self)
                 .store(in: &cancellables)
         }
         
         func getLocation() {
             CLLocationManager
                 .receiveLocationUpdates(from: manager)
                 .compactMap(\.last)
                 .map(\.coordinate)
                 .sink { result in
                     if case let .failure(error) = result {
                         dprint("Error: \(error.localizedDescription)")
                     }
                 } receiveValue: { coordinate in
                     self.coordinate = coordinate
                 }
                 .store(in: &cancellables)
         }
     }
     ```
     **/
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    static func requestLocationAuthorization(
        with manager: CLLocationManager,
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
