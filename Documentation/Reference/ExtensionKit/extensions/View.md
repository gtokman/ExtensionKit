**EXTENSION**

# `View`
```swift
public extension View
```

## Methods
### `fillParent(alignment:)`

```swift
func fillParent(alignment: Alignment = .center) -> some View
```

Fill parent view
- Parameter alignment: alignment
- Returns: View with filled frame

#### Parameters

| Name | Description |
| ---- | ----------- |
| alignment | alignment |

### `if(_:transform:)`

```swift
func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View
```

If a condition is true, transform and return a new view
- Parameters:
  - condition: condition
  - transform: transformation if true
- Returns: new view

#### Parameters

| Name | Description |
| ---- | ----------- |
| condition | condition |
| transform | transformation if true |

### `if(_:if:else:)`

```swift
func `if`<TrueContent: View, FalseContent: View>(
  _ condition: Bool,
  if ifTransform: (Self) -> TrueContent,
  else elseTransform: (Self) -> FalseContent
) -> some View
```

If a condition is true, transform and return a new view
- Parameters:
  - condition: condition
  - ifTransform: true case transform
  - elseTransform: else case transform
- Returns: new view

#### Parameters

| Name | Description |
| ---- | ----------- |
| condition | condition |
| ifTransform | true case transform |
| elseTransform | else case transform |

### `embedInNavigationView()`

```swift
func embedInNavigationView() -> some View
```

Embed Self in `NavigationView`
- Returns: New view with `NavigationView` parent

### `cornerRadius(_:corners:)`

```swift
func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View
```

Round view with specific corners
- Parameters:
  - radius: radius
  - corners: corners to round
- Returns: new rounded view

#### Parameters

| Name | Description |
| ---- | ----------- |
| radius | radius |
| corners | corners to round |

### `debug()`

```swift
func debug() -> Self
```

Debug print view representation
- Returns: Self after printing

### `eraseToAnyView()`

```swift
func eraseToAnyView() -> AnyView
```

Erase view to `AnyView`
- Returns: new view

### `hidden(_:)`

```swift
func hidden(_ hidden: Bool) -> some View
```

Hides the view conditionally
- Parameter hidden: is hidden
- Returns: hidden view but not drawn on screen

#### Parameters

| Name | Description |
| ---- | ----------- |
| hidden | is hidden |