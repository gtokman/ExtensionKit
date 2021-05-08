**EXTENSION**

# `CLLocationManager`
```swift
public extension CLLocationManager
```

## Methods
### `requestLocationWhenInUseAuthorization()`

```swift
func requestLocationWhenInUseAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never>
```

```
class LocationStore: ObservableObject {

    @Published var status: CLAuthorizationStatus = .notDetermined
    let manager = CLLocationManager()
    var cancellables = Set<AnyCancellable>()
    
    func requestPermission() {
        manager
            .requestLocationWhenInUseAuthorization()
            .assign(to: &$status)
    }
}
```

### `requestLocationAlwaysAuthorization()`

```swift
func requestLocationAlwaysAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never>
```

```
class LocationStore: ObservableObject {

    @Published var status: CLAuthorizationStatus = .notDetermined
    let manager = CLLocationManager()
    var cancellables = Set<AnyCancellable>()
    
    func requestPermission() {
        manager
            .requestLocationWhenInUseAuthorization()
            .assign(to: &$status)
    }
}
```

### `receiveLocationUpdates(oneTime:)`

```swift
func receiveLocationUpdates(oneTime: Bool = false) -> AnyPublisher<[CLLocation], Error>
```

```
class LocationStore: ObservableObject {
    
    @Published var coordinate: CLLocationCoordinate2D = .zero
    let manager = CLLocationManager()
    var cancellables = Set<AnyCancellable>()
    
    func requestLocation() {
        manager
            .receiveLocationUpdates()
            .compactMap(\.last)
            .map(\.coordinate)
            .replaceError(with: .zero)
            .assign(to: &$coordinate)
    }
}
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| oneTime | One time location update or constant updates, default: false |