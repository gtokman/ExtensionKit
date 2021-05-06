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
            manager
                 .requestLocationAuthorization(type: .whenInUse)
                 .assign(to: \.status, on: self)
                 .store(in: &cancellables)
         }
         
         func getLocation() {
            manager
                 .receiveLocationUpdates()
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
     */
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    func requestLocationAuthorization(
        type: AuthorizationType
    ) -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: self, authorizationType: type)
            .eraseToAnyPublisher()
    }
    
    /// Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
    /// - Parameters:
    ///   - manager: `CLLocationManager`
    /// - Returns: Publisher with `AuthorizationType`
    func requestLocationAlwaysAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: self, authorizationType: .whenInUse)
            .flatMap { status -> AnyPublisher<CLAuthorizationStatus, Never> in
                if status == CLAuthorizationStatus.authorizedAlways {
                    return AuthorizationPublisher(
                        manager: self,
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
    func receiveLocationUpdates() -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: self)
            .eraseToAnyPublisher()
    }

    /// Authorization access level
    enum AuthorizationType: String {
        case always, whenInUse
    }

}
