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

Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
- Parameters:
  - type: `AuthorizationType`
- Returns: Publisher with `AuthorizationType`

#### Parameters

| Name | Description |
| ---- | ----------- |
| type | `AuthorizationType` |

### `requestLocationAlwaysAuthorization()`

```swift
func requestLocationAlwaysAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never>
```

Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
- Returns: Publisher with `AuthorizationType`

### `receiveLocationUpdates()`

```swift
func receiveLocationUpdates() -> AnyPublisher<[CLLocation], Error>
```

Receive location updates from the `CLLocationManager`
- Returns: Publisher with `[CLLocation]` or `Error`

### `receiveOnTimeLocationUpdate()`

```swift
func receiveOnTimeLocationUpdate() -> AnyPublisher<[CLLocation], Error>
```

Receive location updates from the `CLLocationManager`
- Returns: Publisher with `[CLLocation]` or `Error`
