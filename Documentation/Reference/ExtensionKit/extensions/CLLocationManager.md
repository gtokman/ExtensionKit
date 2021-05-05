**EXTENSION**

# `CLLocationManager`
```swift
public extension CLLocationManager
```

## Methods
### `requestLocationAuthorization(with:type:)`

```swift
static func requestLocationAuthorization(
    with manager: CLLocationManager = .init(),
    type: AuthorizationType
) -> AnyPublisher<CLAuthorizationStatus, Never>
```

Request locaton authorization and subscribe to `CLAuthorizationStatus` updates
- Parameters:
  - manager: `CLLocationManager`
  - type: `AuthorizationType`
- Returns: Publisher with `AuthorizationType`

#### Parameters

| Name | Description |
| ---- | ----------- |
| manager | `CLLocationManager` |
| type | `AuthorizationType` |

### `requestLocationAlwaysAuthorization(with:)`

```swift
static func requestLocationAlwaysAuthorization(
    with manager: CLLocationManager = .init()
) -> AnyPublisher<CLAuthorizationStatus, Never>
```

Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
- Parameters:
  - manager: `CLLocationManager`
- Returns: Publisher with `AuthorizationType`

#### Parameters

| Name | Description |
| ---- | ----------- |
| manager | `CLLocationManager` |

### `receiveLocationUpdates(from:)`

```swift
static func receiveLocationUpdates(
    from manager: CLLocationManager = .init()
) -> AnyPublisher<[CLLocation], Error>
```

Receive location updates from the `CLLocationManager`
- Parameter manager: `CLLocationManager`
- Returns: Publisher with `[CLLocation]` or `Error`

#### Parameters

| Name | Description |
| ---- | ----------- |
| manager | `CLLocationManager` |