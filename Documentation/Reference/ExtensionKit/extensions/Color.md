**EXTENSION**

# `Color`
```swift
public extension Color
```

## Properties
### `inverted`

```swift
var inverted: Color
```

Inverse color

## Methods
### `hex(_:alpha:)`

```swift
static func hex(_ hex: UInt, alpha: Double = 1) -> Self
```

Initialize with HEX
- Parameter hex: HEX UInt value
- Returns: Color

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex | HEX UInt value |

### `hex(_:alpha:)`

```swift
static func hex(_ hex: String, alpha: CGFloat = 1) -> Self
```

Initialize with HEX
- Parameter hex: HEX String value
- Returns: Color

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex | HEX String value |

### `init(hex:)`

```swift
init(hex: String)
```

Initialize with HEX
- Parameter hex: HEX

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex | HEX |

### `random(opacity:)`

```swift
static func random(opacity: CGFloat = 1.0) -> Color
```

Generate a random color
- Parameter opacity: opacity
- Returns: New color

#### Parameters

| Name | Description |
| ---- | ----------- |
| opacity | opacity |

### `lighten(by:)`

```swift
func lighten(by percentage: CGFloat = 30.0) -> Color
```

Lighten color
- Parameter percentage: percentage (1 -100), default: 30
- Returns: new color

#### Parameters

| Name | Description |
| ---- | ----------- |
| percentage | percentage (1 -100), default: 30 |

### `darken(by:)`

```swift
func darken(by percentage: CGFloat = 30.0) -> Color
```

Darken color
- Parameter percentage: percentage (1 -100), default: 30
- Returns: new color

#### Parameters

| Name | Description |
| ---- | ----------- |
| percentage | percentage (1 -100), default: 30 |