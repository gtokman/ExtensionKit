**EXTENSION**

# `UIButton`

## Properties
### `normalStateBackgroundColor`

```swift
@IBInspectable var normalStateBackgroundColor: UIColor?
```

### `disabledStateBackgroundColor`

```swift
@IBInspectable var disabledStateBackgroundColor: UIColor?
```

### `highlightedStateBackgroundColor`

```swift
@IBInspectable var highlightedStateBackgroundColor: UIColor?
```

### `selectedStateBackgroundColor`

```swift
@IBInspectable var selectedStateBackgroundColor: UIColor?
```

### `titleImageSpacing`

```swift
@IBInspectable var titleImageSpacing: CGFloat
```

### `isTitleImagePositionReversed`

```swift
var isTitleImagePositionReversed: Bool
```

### `backgroundImageView`

```swift
var backgroundImageView: UIImageView?
```

## Methods
### `setBackgroundColor(_:for:)`

```swift
func setBackgroundColor(_ color: UIColor, for state: UIControl.State)
```

Set background color for state
- Parameters:
  - color: color
  - state: state

#### Parameters

| Name | Description |
| ---- | ----------- |
| color | color |
| state | state |

### `centerTextAndImage(spacing:forceRightToLeft:)`

```swift
func centerTextAndImage(spacing: CGFloat, forceRightToLeft: Bool)
```

Adjust `contentEdgeInsets`, `imageEdgeInsets` and `titleEdgeInsets` with appropriate value so as to make a specified spacing between the button's title and image.
- Reference: https://stackoverflow.com/questions/4564621/aligning-text-and-image-on-uibutton-with-imageedgeinsets-and-titleedgeinsets

- Parameters:
  - spacing: The desired spacing to make.
  - forceRightToLeft: Whether the content of the button is in `forceRightToLeft` semantic.

#### Parameters

| Name | Description |
| ---- | ----------- |
| spacing | The desired spacing to make. |
| forceRightToLeft | Whether the content of the button is in `forceRightToLeft` semantic. |

### `addAction(for:closure:)`

```swift
func addAction(for controlEvent: UIControl.Event, closure: @escaping () -> Void)
```

Button action for event
- Parameters:
  - controlEvent: Event
  - closure: Closure to run

#### Parameters

| Name | Description |
| ---- | ----------- |
| controlEvent | Event |
| closure | Closure to run |