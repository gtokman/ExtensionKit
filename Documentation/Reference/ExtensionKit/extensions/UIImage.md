**EXTENSION**

# `UIImage`

## Properties
### `isSquare`

```swift
var isSquare: Bool
```

Is square aspect ratio

### `sizeOnDisk`

```swift
var sizeOnDisk: String
```

Size in KB or MB

### `heightForScreenWidth`

```swift
var heightForScreenWidth: CGFloat
```

Height for screen width

### `orientationFixed`

```swift
var orientationFixed: UIImage
```

Correct the direction of the picture so that it positioned correctly

- Returns: Image

## Methods
### `init(qrCodeFrom:)`

```swift
convenience init?(qrCodeFrom string: String)
```

Create QR code from string
- Parameter string: String for QR code

#### Parameters

| Name | Description |
| ---- | ----------- |
| string | String for QR code |

### `withStarShape(size:strokeColor:lineWidth:fillColor:)`

```swift
static func withStarShape(size: CGSize, strokeColor: UIColor = .clear, lineWidth: CGFloat = 2.0, fillColor: UIColor?) -> UIImage?
```

Draw a star
- Parameters:
  - size: Size
  - strokeColor: Stroke color
  - lineWidth: Line width
  - fillColor: Fill color
- Returns: Drawn star as UIImage

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | Size |
| strokeColor | Stroke color |
| lineWidth | Line width |
| fillColor | Fill color |

### `withTintColor(_:)`

```swift
func withTintColor(_ color: UIColor) -> UIImage?
```

Returns an identical image with specified tint color. Note that the returned image is with rendering mode `.alwaysOriginal`

- Reference

  https://stackoverflow.com/questions/31803157/how-can-i-color-a-uiimage-in-swift

- Parameter color: The tint color
- Returns: An identical image with specified tint color

#### Parameters

| Name | Description |
| ---- | ----------- |
| color | The tint color |

### `aspectHeight(for:)`

```swift
func aspectHeight(for width: CGFloat) -> CGFloat
```

Scale the height of the given width proportionally

- parameter width: width

- returns: New height

#### Parameters

| Name | Description |
| ---- | ----------- |
| width | width |

### `aspectWidth(for:)`

```swift
func aspectWidth(for height: CGFloat) -> CGFloat
```

Scale the width of the given height proportionally

- parameter height: Height

- returns: New width

#### Parameters

| Name | Description |
| ---- | ----------- |
| height | Height |

### `aspectFitSize(forBindingSize:)`

```swift
func aspectFitSize(forBindingSize binding: CGSize) -> CGSize
```

Keep the aspect ratio and return the fitting size of the given size

- Parameter binding: Size
- Returns: New size

#### Parameters

| Name | Description |
| ---- | ----------- |
| binding | Size |

### `image(withPureColor:for:rounded:)`

```swift
class func image(withPureColor color: UIColor, for rect: CGRect, rounded: Bool) -> UIImage?
```

Get an single-colored image

- Parameters:
  - color: The color
  - rect: The rect to draw in a CGContext.
- Returns: An single-colored image object, nil if any problems occur, such as CGRect.zero got passed.

#### Parameters

| Name | Description |
| ---- | ----------- |
| color | The color |
| rect | The rect to draw in a CGContext. |

### `subImage(in:)`

```swift
func subImage(in rect: CGRect) -> UIImage?
```

Get certain part of image

- Parameter rect: Part of the image
- Returns: Image

#### Parameters

| Name | Description |
| ---- | ----------- |
| rect | Part of the image |

### `resized(to:)`

```swift
func resized(to size: CGSize) -> UIImage?
```

Redraw the image to the specified size

- Parameter size: Size
- Returns: Image

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | Size |

### `resizedImageWithAspectFitSize(forBindingSize:)`

```swift
func resizedImageWithAspectFitSize(forBindingSize binding: CGSize) -> UIImage?
```

### `square()`

```swift
func square() -> UIImage?
```

Resize the image so that its width and height are equal.

- Returns: A newly created image.

### `with(backgroundColor:cornerRadius:insets:)`

```swift
func with(backgroundColor: UIColor, cornerRadius: CGFloat, insets: UIEdgeInsets) -> UIImage?
```

Redraw a new image with the given requirements.

- Parameters:
  - backgroundColor: The background color of the image.
  - cornerRadius: The corner radius of the image, pass 0.0 if you perfer a squared one.
  - insets: The inset to apply to the image.
- Returns: A newly created image.

#### Parameters

| Name | Description |
| ---- | ----------- |
| backgroundColor | The background color of the image. |
| cornerRadius | The corner radius of the image, pass 0.0 if you perfer a squared one. |
| insets | The inset to apply to the image. |

### `arrowHead(direction:color:size:lineWidth:)`

```swift
static func arrowHead(direction: ArrowDirection, color: UIColor, size: CGSize, lineWidth: CGFloat = 2.0) -> UIImage?
```

### `borderImage(size:backgroundColor:borderColor:borderWidth:cornerRadius:)`

```swift
class func borderImage(size: CGSize, backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage?
```

Draw a image with a border
- Parameters:
  - size: size
  - backgroundColor: color
  - borderColor: border color
  - borderWidth: border width
  - cornerRadius: radius
- Returns: New image

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | size |
| backgroundColor | color |
| borderColor | border color |
| borderWidth | border width |
| cornerRadius | radius |

### `buttonBackgroundBorderImage(backgroundColor:borderColor:borderWidth:cornerRadius:)`

```swift
class func buttonBackgroundBorderImage(backgroundColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) -> UIImage?
```

Draw background image
- Parameters:
  - backgroundColor: color
  - borderColor: border color
  - borderWidth: width
  - cornerRadius: radius
- Returns: New image

#### Parameters

| Name | Description |
| ---- | ----------- |
| backgroundColor | color |
| borderColor | border color |
| borderWidth | width |
| cornerRadius | radius |