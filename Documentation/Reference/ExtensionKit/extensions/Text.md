**EXTENSION**

# `Text`
```swift
public extension Text
```

## Methods
### `init(_:dateStyle:)`

```swift
init(_ date: Date, dateStyle: DateFormatter.Style = .full)
```

Create Text from date formate
- Parameters:
  - date: `Date`
  - dateStyle: `DateFormatter.Style`, default .full

#### Parameters

| Name | Description |
| ---- | ----------- |
| date | `Date` |
| dateStyle | `DateFormatter.Style`, default .full |

### `init(_:formatter:)`

```swift
init(_ date: Date, formatter: DateFormatter = Text.dateFormatter)
```

Create Text with date formatter string
- Parameters:
  - date: `Date`
  - formatter: `DateFormatter`

#### Parameters

| Name | Description |
| ---- | ----------- |
| date | `Date` |
| formatter | `DateFormatter` |

### `system(_:weight:design:)`

```swift
func system(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .default) -> Text
```

Text with system font
- Parameters:
  - size: size, default 18
  - weight: font weight, default regular
  - design: font design, default .default
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | size, default 18 |
| weight | font weight, default regular |
| design | font design, default .default |

### `monospaced(_:weight:design:)`

```swift
func monospaced(_ size: CGFloat = 18, weight: SwiftUI.Font.Weight = .regular, design: SwiftUI.Font.Design = .monospaced) -> Text
```

Text with system font and monospaced
- Parameters:
  - size: size, default 18
  - weight: font weight, default regular
  - design: font design, default .monospaced
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | size, default 18 |
| weight | font weight, default regular |
| design | font design, default .monospaced |

### `templateSize(for:)`

```swift
func templateSize(for value: String) -> some View
```

Hidden `View` with frame of String vale
- Parameter value: String
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | String |