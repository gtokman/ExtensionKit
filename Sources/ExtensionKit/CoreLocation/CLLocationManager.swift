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
    ///   - type: `AuthorizationType`
    /// - Returns: Publisher with `AuthorizationType`
    func requestLocationWhenInUseAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: self, authorizationType: .whenInUse)
            .eraseToAnyPublisher()
    }
    
    /// Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
    /// - Returns: Publisher with `AuthorizationType`
    func requestLocationAlwaysAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: self, authorizationType: .whenInUse)
            .flatMap { status -> AnyPublisher<CLAuthorizationStatus, Never> in
                if status == CLAuthorizationStatus.authorizedWhenInUse {
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
    /// - Returns: Publisher with `[CLLocation]` or `Error`
    func receiveLocationUpdates() -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: self)
            .eraseToAnyPublisher()
    }
    
    /// Receive location updates from the `CLLocationManager`
    /// - Returns: Publisher with `[CLLocation]` or `Error`
    func receiveOnTimeLocationUpdate() -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: self, onTimeUpdate: true)
            .eraseToAnyPublisher()
    }

    /// Authorization access level
    internal enum AuthorizationType: String {
        case always, whenInUse
    }

}
