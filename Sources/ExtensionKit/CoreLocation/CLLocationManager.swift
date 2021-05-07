import Combine
import CoreLocation

public extension CLLocationManager {
    
    /**
     ```
     class LocationStore: ObservableObject {
     
         @Published var status: CLAuthorizationStatus = .notDetermined
         let manager = CLLocationManager()
         var cancellables = Set<AnyCancellable>()
         
         func requestPermission() {
            manager
                 .requestLocationWhenInUseAuthorization()
                 .assign(to: \.status, on: self)
                 .store(in: &cancellables)
         }
     }
     ```
     */
    /// Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
    /// - Returns: Publisher with CLAuthorizationStatus
    func requestLocationWhenInUseAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never> {
        AuthorizationPublisher(manager: self, authorizationType: .whenInUse)
            .eraseToAnyPublisher()
    }
    
    /**
     ```
     class LocationStore: ObservableObject {
     
         @Published var status: CLAuthorizationStatus = .notDetermined
         let manager = CLLocationManager()
         var cancellables = Set<AnyCancellable>()
         
         func requestPermission() {
            manager
                 .requestLocationAlwaysAuthorization()
                 .assign(to: \.status, on: self)
                 .store(in: &cancellables)
         }
     }
     ```
     */
    /// Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt
    /// - Returns: Publisher with CLAuthorizationStatus
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

    /**
     ```
     class LocationStore: ObservableObject {
         
         @Published var coordinate: CLLocationCoordinate2D = .zero
         let manager = CLLocationManager()
         var cancellables = Set<AnyCancellable>()
         
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
    /// Receive location updates from the `CLLocationManager`
    /// - Parameter oneTime: One time location update or constant updates, default: false
    /// - Returns: Publisher with [CLLocation] or Error
    func receiveLocationUpdates(oneTime: Bool = false) -> AnyPublisher<[CLLocation], Error> {
        LocationPublisher(manager: self, onTimeUpdate: oneTime)
            .eraseToAnyPublisher()
    }
    
    /// Authorization access level
    internal enum AuthorizationType: String {
        case always, whenInUse
    }

}
