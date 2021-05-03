**EXTENSION**

# `UIColor`

## Properties
### `isLight`

```swift
var isLight: Bool
```

Check whether self is a light/bright color.
https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright

### `isExtremelyLight`

```swift
var isExtremelyLight: Bool
```

Check whether self is a light/bright color.
https://stackoverflow.com/questions/2509443/check-if-uicolor-is-dark-or-bright

## Methods
### `init(rgbValue:alpha:)`

```swift
convenience init(rgbValue: UInt, alpha: CGFloat = 1)
```

New color from RGB value
- Parameters:
  - rgbValue: value
  - alpha: alpha

#### Parameters

| Name | Description |
| ---- | ----------- |
| rgbValue | value |
| alpha | alpha |

### `init(hexCode:alpha:)`

```swift
convenience init(hexCode: String, alpha: CGFloat = 1)
```

Color from HEX
- Parameter hexCode: Hex w/o `#`

#### Parameters

| Name | Description |
| ---- | ----------- |
| hexCode | Hex w/o `#` |

### `random(alpha:)`

```swift
static func random(alpha: CGFloat = 1.0) -> UIColor
```

Random color
- Parameter alpha: alpha
- Returns: new color

#### Parameters

| Name | Description |
| ---- | ----------- |
| alpha | alpha |

### `lighten(by:)`

```swift
func lighten(by percentage: CGFloat = 30.0) -> UIColor
```

Darken color
- Parameter percentage: percentage
- Returns: new color

#### Parameters

| Name | Description |
| ---- | ----------- |
| percentage | percentage |

### `darken(by:)`

```swift
func darken(by percentage: CGFloat = 30.0) -> UIColor
```

Darken color
- Parameter percentage: percentage
- Returns: new color

#### Parameters

| Name | Description |
| ---- | ----------- |
| percentage | percentage |

### `dynamicColor(light:dark:)`

```swift
static func dynamicColor(light: UIColor, dark: UIColor) -> UIColor
```

Color for UI appearance ex: dark/light mode
- Parameters:
  - light: Light Color
  - dark: Dark Color
- Returns: UIColor

#### Parameters

| Name | Description |
| ---- | ----------- |
| light | Light Color |
| dark | Dark Color |