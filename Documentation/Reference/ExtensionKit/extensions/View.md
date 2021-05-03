**EXTENSION**

# `View`
```swift
public extension View
```

## Properties
### `hosted`

```swift
var hosted: UIHostingController<Self>
```

Self wrapped in an `UIHostingController`

## Methods
### `fillEqual(length:alignment:)`

```swift
func fillEqual(length: CGFloat, alignment: Alignment = .center) -> some View
```

Fill frame height and width to the same length
- Parameters:
  - length: Length to set
  - alignment: Aligment
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| length | Length to set |
| alignment | Aligment |

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

### `fillWidth()`

```swift
func fillWidth() -> some View
```

Fill parent's width
- Returns: view

### `fillHeight()`

```swift
func fillHeight() -> some View
```

Fill parent's height
- Returns: view

### `fillFlexible(_:alignment:)`

```swift
func fillFlexible(
    _ flexibleAxis: Axis.Set = [.horizontal, .vertical],
    alignment: Alignment = .center
) -> some View
```

Similar to distribuation fill on `UIStackView`, take up all availabe space of parent
- Parameters:
  - flexibleAxis: Axis to fill
  - alignment: Alignment
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| flexibleAxis | Axis to fill |
| alignment | Alignment |

### `if(_:transform:)`

```swift
func `if`<TrueContent: View>(_ condition: Bool, transform: (Self) -> TrueContent) -> some View
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

### `ifLet(_:_:)`

```swift
func `ifLet`<Content: View, Value>(
    _ value: Value?,
    _ modifier: (Self, Value) -> Content) -> some View
```

Conditionally apply a modifier to the view based on if the optional exists
- Parameters:
  - value: Optional value
  - modifier: Modifier to run on value if it exists
- Returns: Modified self if optional has a value

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | Optional value |
| modifier | Modifier to run on value if it exists |

### `embedInNavigationView()`

```swift
func embedInNavigationView() -> some View
```

Embed Self in `NavigationView`
- Returns: New view with `NavigationView` parent

### `embedInScrollView(_:showsIndicators:)`

```swift
func embedInScrollView(_ axis: Axis.Set = .vertical,
                       showsIndicators: Bool = false) -> some View
```

Embed Self in `ScrollView`
- Returns: New view with `ScrollView` parent

### `embedInTabView(_:paged:pageIndicators:)`

```swift
func embedInTabView<Selection: Hashable>(
    _ selection: Binding<Selection>? = nil,
    paged: Bool = true,
    pageIndicators: PageTabViewStyle.IndexDisplayMode = .always
) -> some View
```

Embed Self in `TabView`
- Parameters:
  - selection: selection binding
  - paged: page style or not (`PageTabViewStyle`)
  - pageIndicators: show page indicators, default .always
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| selection | selection binding |
| paged | page style or not (`PageTabViewStyle`) |
| pageIndicators | show page indicators, default .always |

### `embedInVerticalPagingTabView(_:pageIndicators:)`

```swift
func embedInVerticalPagingTabView<Selection: Hashable>(
    _ selection: Binding<Selection>? = nil,
    pageIndicators: PageTabViewStyle.IndexDisplayMode = .never
) -> some View
```

```
 ForEach(0 ..< 5) { item in
     Rectangle()
         .foregroundColor(.random())
 }.embedInVerticalPagingTabView($selection)
```

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

### `eraseToAnyView()`

```swift
func eraseToAnyView() -> AnyView
```

Erase view to `AnyView`
- Returns: new view

### `hide(if:)`

```swift
func hide(if hidden: Bool) -> some View
```

Hides the view conditionally
- Parameter hidden: is hidden
- Returns: hidden view but not drawn on screen

#### Parameters

| Name | Description |
| ---- | ----------- |
| hidden | is hidden |

### `shimmer(isActive:speed:angle:)`

```swift
func shimmer(
    isActive: Bool = true,
    speed: Double = 0.15,
    angle: Angle = .init(degrees: 70)
) -> some View
```

Loading shimmer animation on view
- Parameters:
  - isActive: is shimmer animation active
  - speed: speed, default: 0.15
  - angle: angle of animation, default: 70º
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| isActive | is shimmer animation active |
| speed | speed, default: 0.15 |
| angle | angle of animation, default: 70º |

### `circleMotion(isActive:circleColor:)`

```swift
func circleMotion(
    isActive: Bool = true,
    circleColor: Color = .gray
) -> some View
```

Add animating circles to view
- Parameters:
  - isActive: is animation active
  - circleColor: circle foreground color
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| isActive | is animation active |
| circleColor | circle foreground color |

### `addBorder(_:width:cornerRadius:)`

```swift
func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle
```

Overlay border on view
- Parameters:
  - content: ShapeStyle view
  - width: border width
  - cornerRadius: corner radius
- Returns: view

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | ShapeStyle view |
| width | border width |
| cornerRadius | corner radius |

### `gradientOverlay(colors:start:end:)`

```swift
func gradientOverlay(
    colors: Color...,
    start: UnitPoint = .top,
    end: UnitPoint = .bottom) -> some View
```

Addd a `LinearGradient` overlayed on View
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

### `gradientBackground(colors:start:end:)`

```swift
func gradientBackground(
    colors: Color...,
    start: UnitPoint = .top,
    end: UnitPoint = .bottom) -> some View
```

Addd a `LinearGradient` background on View
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

### `safeArea(withBackground:safeAreaRegions:edges:)`

```swift
func safeArea<Background: View>(
    withBackground backgroundView: Background,
    safeAreaRegions: SafeAreaRegions = .all,
    edges: Edge.Set = .all
) -> some View
```

Expand safe area on the background of the view
- Parameters:
  - backgroundView: view to ignore safe area
  - safeAreaRegions: safe area regions
  - edges: edges
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| backgroundView | view to ignore safe area |
| safeAreaRegions | safe area regions |
| edges | edges |

### `navigationBarColors(background:text:)`

```swift
func navigationBarColors(background: UIColor, text: UIColor) -> some View
```

Set Navigation bar background color and text
- Parameters:
  - background: background color
  - text: text color
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| background | background color |
| text | text color |

### `background(alignment:content:)`

```swift
func background<Content: View>(
    alignment: Alignment = .center,
    @ViewBuilder content: () -> Content
) -> some View
```

Container that doesn’t leak outside the safe area, only the elements in its background
- Parameters:
  - alignment: alignment
  - content: content
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| alignment | alignment |
| content | content |

### `hideKeyboard()`

```swift
func hideKeyboard()
```

Hide keyboard

### `keyboardState(isVisible:)`

```swift
func keyboardState(isVisible: Binding<Bool>) -> some View
```

Receive keyboard status updates
- Parameter isVisible: is keyboard visible
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| isVisible | is keyboard visible |

### `debugPrint(_:)`

```swift
func debugPrint(_ vars: Any...) -> some View
```

Debug print
- Parameter vars: item to print
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| vars | item to print |

### `debugAction(_:)`

```swift
func debugAction(_ closure: () -> Void) -> Self
```

Debug action
- Parameter closure: action
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| closure | action |

### `debugModifier(_:)`

```swift
func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View
```

Debug visual modifier
- Parameter modifier: View modifier
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| modifier | View modifier |

### `debugBorder(_:width:)`

```swift
func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View
```

Debug only border
- Parameters:
  - color: color
  - width: width
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| color | color |
| width | width |

### `debugBackground(_:)`

```swift
func debugBackground(_ color: Color = .red) -> some View
```

Debug only background
- Parameter color: color
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| color | color |

### `debug()`

```swift
func debug() -> Self
```

Debug print view representation
- Returns: Self after printing

### `times(_:)`

```swift
func times(_ value: UInt) -> some View
```

Repeat View n times
- Parameter value: repeat upto not including
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | repeat upto not including |

### `useSize(of:)`

```swift
func useSize<Content: View>(of content: @autoclosure () -> Content) -> some View
```

Overlay View on content size
- Parameter content: content size
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | content size |

### `onReceive(_:assignTo:)`

```swift
func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output>) -> some View where P.Failure == Never
```

Subscribe and blind ouput to View property
- Parameters:
  - publisher: publisher
  - binding: binding
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| publisher | publisher |
| binding | binding |

### `onReceive(_:assignTo:)`

```swift
func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output?>) -> some View where P.Failure == Never
```

Subscribe and blind optional ouput to View property
- Parameters:
  - publisher: publisher
  - binding: binding
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| publisher | publisher |
| binding | binding |

### `scrollOffsetX(_:)`

```swift
func scrollOffsetX(_ offsetX: Binding<CGFloat>?) -> some View
```

Get the scroll view content offset X
- Parameter offsetX: Binding for offset
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| offsetX | Binding for offset |

### `scrollOffsetY(_:)`

```swift
func scrollOffsetY(_ offsetY: Binding<CGFloat>?) -> some View
```

Get the scroll view content offset Y
- Parameter offsetY: Binding for offset
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| offsetY | Binding for offset |