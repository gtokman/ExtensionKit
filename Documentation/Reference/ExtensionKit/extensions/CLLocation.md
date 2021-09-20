**EXTENSION**

# `CLLocation`
```swift
public extension CLLocation
```

## Methods
### `init(from:)`

```swift
convenience init(from coordinate: CLLocationCoordinate2D)
```

`CLLocation` from `CLLocationCoordinate2D`
- Parameter coordinate: `CLLocationCoordinate2D`

#### Parameters

| Name | Description |
| ---- | ----------- |
| coordinate | `CLLocationCoordinate2D` |

### `reverseGeocode()`

```swift
func reverseGeocode() -> Deferred<Future<[CLPlacemark], GeocodeError>>
```

Reverse geocode a `CLLocation`
- Parameter location: `CLLocation`
- Returns: Future with Result<[`CLPlacemark`], `GeocodeError`>

#### Parameters

| Name | Description |
| ---- | ----------- |
| location | `CLLocation` |