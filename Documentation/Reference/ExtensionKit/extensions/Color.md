**EXTENSION**

# `Color`
```swift
public extension Color
```

## Methods
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