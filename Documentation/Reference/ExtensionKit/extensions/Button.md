**EXTENSION**

# `Button`
```swift
public extension Button where Label == Image
```

## Methods
### `init(systemName:action:)`

```swift
init(systemName: String, action: @escaping () -> Void)
```

Initialize button with system image and trailing action
- Parameters:
  - systemName: System image name
  - action: action

#### Parameters

| Name | Description |
| ---- | ----------- |
| systemName | System image name |
| action | action |

### `init(imageName:action:)`

```swift
init(imageName: String, action: @escaping () -> Void)
```

Initialize button with local image and trailing action
- Parameters:
  - systemName: System image name
  - action: action

#### Parameters

| Name | Description |
| ---- | ----------- |
| systemName | System image name |
| action | action |

### `shadowButton(titleColor:background:padding:shadow:cornerRadius:)`

```swift
func shadowButton(
    titleColor: Color = .white,
    background: Color = .blue,
    padding: (edges: Edge.Set, length: CGFloat) = (.all, 10),
    shadow: (radius: CGFloat, alpha: CGFloat, y: CGFloat) = (10, 0.15, 4),
    cornerRadius: CGFloat = 10
) -> some View
```

Create a `Button` with foreground, background, shadow, cornerRadius
- Parameters:
  - titleColor: foreground color
  - background: background color
  - padding: padding
  - shadow: shadow
  - cornerRadius: corner radius
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| titleColor | foreground color |
| background | background color |
| padding | padding |
| shadow | shadow |
| cornerRadius | corner radius |