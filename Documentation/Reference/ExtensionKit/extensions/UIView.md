**EXTENSION**

# `UIView`

## Properties
### `anchorPoint`

```swift
var anchorPoint: CGPoint
```

Set anchor point on layer

### `layerCornerRadius`

```swift
@IBInspectable var layerCornerRadius: CGFloat
```

Set corner radius on layer

### `layerBorderWidth`

```swift
@IBInspectable var layerBorderWidth: CGFloat
```

Set border width on layer

### `layerBorderColor`

```swift
@IBInspectable var layerBorderColor: UIColor?
```

Set a border color on layer

## Methods
### `addCleanBorder(cornerRadius:color:width:targetBounds:)`

```swift
func addCleanBorder(cornerRadius: CGFloat, color: UIColor, width: CGFloat, targetBounds: CGRect?)
```

Add border using path
- Parameters:
  - cornerRadius: radius
  - color: color
  - width: width
  - targetBounds: bounds or view bounds

#### Parameters

| Name | Description |
| ---- | ----------- |
| cornerRadius | radius |
| color | color |
| width | width |
| targetBounds | bounds or view bounds |

### `addCleanBorder(roundingCorners:cornerRadii:color:width:targetBounds:)`

```swift
func addCleanBorder(roundingCorners: UIRectCorner, cornerRadii: CGSize, color: UIColor, width: CGFloat, targetBounds: CGRect?)
```

Add border using path
- Parameters:
  - roundingCorners: Corners to round
  - cornerRadii: radius
  - color: color
  - width: width
  - targetBounds: view bounds

#### Parameters

| Name | Description |
| ---- | ----------- |
| roundingCorners | Corners to round |
| cornerRadii | radius |
| color | color |
| width | width |
| targetBounds | view bounds |

### `addTransparentGradientLayer(frame:toColor:minAlpha:maxAlpha:from:to:)`

```swift
func addTransparentGradientLayer(frame: CGRect? = nil, toColor: UIColor, minAlpha: CGFloat, maxAlpha: CGFloat, from start: GradientLayerChangingDirection, to end: GradientLayerChangingDirection) -> CAGradientLayer
```

Add a transparent gradient layer

- Parameters:
  - frame: View frame (default to bounds)
  - toColor: Color to add
  - minAlpha: Alpha
  - maxAlpha: End alpha
  - start: Start direction
  - end: End direction

#### Parameters

| Name | Description |
| ---- | ----------- |
| frame | View frame (default to bounds) |
| toColor | Color to add |
| minAlpha | Alpha |
| maxAlpha | End alpha |
| start | Start direction |
| end | End direction |

### `sizeToFitConstraintedBasedLayout()`

```swift
func sizeToFitConstraintedBasedLayout()
```

Resizes `self.frame` so as to fit the constraint-based layout.

### `shakeToIndicateError()`

```swift
func shakeToIndicateError()
```

Commit a shake animation and vibrate to indicate the occured error.
