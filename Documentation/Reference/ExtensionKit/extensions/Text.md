**EXTENSION**

# `Text`
```swift
public extension Text
```

## Methods
### `default(_:weight:design:)`

```swift
func `default`(_ size: CGFloat = 18, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View
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
func monospaced(_ size: CGFloat = 18, weight: Font.Weight = .regular, design: Font.Design = .monospaced) -> some View
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