**EXTENSION**

# `Text`
```swift
public extension Text
```

## Methods
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
