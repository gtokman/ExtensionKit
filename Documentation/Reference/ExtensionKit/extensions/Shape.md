**EXTENSION**

# `Shape`
```swift
public extension Shape
```

## Methods
### `gradientFill(colors:start:end:)`

```swift
func gradientFill(
    colors: Color...,
    start: UnitPoint = .top,
    end: UnitPoint = .bottom) -> some View
```

Addd a `LinearGradient` fill on Shape
- Parameters:
  - colors: Colors
  - start: Start, default top
  - end: End, default bottom
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| colors | Colors |
| start | Start, default top |
| end | End, default bottom |