**EXTENSION**

# `CLLocationCoordinate2D`
```swift
extension CLLocationCoordinate2D: Equatable
```

## Methods
### `==(_:_:)`

```swift
public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool
```

Equatable coordinates

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

Encode a `CLLocationCoordinate2D`
- Parameter encoder: Encoder
- Throws: `EncodingError`

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | Encoder |

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

Decode `CLLocationCoordinate2D` from data
- Parameter decoder: Decoder
- Throws: `DecodingError`

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | Decoder |