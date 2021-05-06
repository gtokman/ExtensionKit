**EXTENSION**

# `CLLocationManager`
```swift
public extension CLLocationManager
```

## Methods
### `requestLocationAuthorization(type:)`

```swift
func requestLocationAuthorization(
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

### `requestLocationAlwaysAuthorization()`

```swift
func requestLocationAlwaysAuthorization() -> AnyPublisher<CLAuthorizationStatus, Never>
```

Request locaton **always** authorization `CLAuthorizationStatus` with **upgrade** prompt (experimental)
- Parameters:
  - manager: `CLLocationManager`
- Returns: Publisher with `AuthorizationType`

#### Parameters

| Name | Description |
| ---- | ----------- |
| manager | `CLLocationManager` |

### `receiveLocationUpdates()`

```swift
func receiveLocationUpdates() -> AnyPublisher<[CLLocation], Error>
```

Receive location updates from the `CLLocationManager`
- Parameter manager: `CLLocationManager`
- Returns: Publisher with `[CLLocation]` or `Error`

#### Parameters

| Name | Description |
| ---- | ----------- |
| manager | `CLLocationManager` |