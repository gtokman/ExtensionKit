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
            .assign(to: \.status, on: self)
            .store(in: &cancellables)
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
            .requestLocationAlwaysAuthorization()
            .assign(to: \.status, on: self)
            .store(in: &cancellables)
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

#### Parameters

| Name | Description |
| ---- | ----------- |
| oneTime | One time location update or constant updates, default: false |