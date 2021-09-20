**EXTENSION**

# `View`
```swift
extension View
```

## Properties
### `hosted`

```swift
public var hosted: UIHostingController<Self>
```

Self wrapped in an `UIHostingController`

## Methods
### `fillEqual(length:alignment:)`

```swift
public func fillEqual(length: CGFloat, alignment: Alignment = .center) -> some View
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
public func fillParent(alignment: Alignment = .center) -> some View
```

Fill parent view
- Parameter alignment: alignment
- Returns: View with filled frame

#### Parameters

| Name | Description |
| ---- | ----------- |
| alignment | alignment |

### `fillFlexible(_:alignment:)`

```swift
public func fillFlexible(
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

### `embedInNavigationView()`

```swift
public func embedInNavigationView() -> some View
```

Embed Self in `NavigationView`
- Returns: New view with `NavigationView` parent

### `embedInScrollView(_:showsIndicators:)`

```swift
public func embedInScrollView(
    _ axis: Axis.Set = .vertical,
    showsIndicators: Bool = false
) -> some View
```

Embed Self in `ScrollView`
- Returns: New view with `ScrollView` parent

### `embedInVerticalPagingTabView(_:pageIndicators:)`

```swift
public func embedInVerticalPagingTabView<Selection: Hashable>(
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
public func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View
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

### `center(alignment:)`

```swift
public func center(alignment: Alignment = .center) -> some View
```

Center a view in parent local coor space
- Parameter alignment: aligment of centered view
- Returns: new view

#### Parameters

| Name | Description |
| ---- | ----------- |
| alignment | aligment of centered view |

### `eraseToAnyView()`

```swift
public func eraseToAnyView() -> AnyView
```

Erase view to `AnyView`
- Returns: new view

### `hide(if:)`

```swift
public func hide(if hidden: Bool) -> some View
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
public func shimmer(
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
public func circleMotion(
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
public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle
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
public func gradientOverlay(
    colors: Color...,
    start: UnitPoint = .top,
    end: UnitPoint = .bottom
) -> some View
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
public func gradientBackground(
    colors: Color...,
    start: UnitPoint = .top,
    end: UnitPoint = .bottom
) -> some View
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
public func safeArea<Background: View>(
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
public func navigationBarColors(background: UIColor, text: UIColor) -> some View
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
public func background<Content: View>(
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
public func hideKeyboard()
```

Hide keyboard

### `keyboardState(info:)`

```swift
public func keyboardState(info: Binding<KeyboardInfo>) -> some View
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
public func debugPrint(_ vars: Any...) -> some View
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
public func debugAction(_ closure: () -> Void) -> Self
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
public func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View
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
public func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View
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
public func debugBackground(_ color: Color = .red) -> some View
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
public func debug() -> Self
```

Debug print view representation
- Returns: Self after printing

### `times(_:)`

```swift
public func times(_ value: UInt) -> some View
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
public func useSize<Content: View>(of content: @autoclosure () -> Content) -> some View
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
public func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output>) -> some View where P.Failure == Never
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
public func onReceive<P: Publisher>(_ publisher: P, assignTo binding: Binding<P.Output?>) -> some View where P.Failure == Never
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

### `scrollOffset(_:)`

```swift
public func scrollOffset(_ offset: Binding<CGPoint>) -> some View
```

Get the scroll view content offset X
- Parameter offsetX: Binding for offset
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| offsetX | Binding for offset |

### `shadowButton(titleColor:background:padding:shadow:cornerRadius:)`

```swift
public func shadowButton(
    titleColor: Color = .white,
    background: Color = .blue,
    padding: (edges: Edge.Set, length: CGFloat) = (.all, 10),
    shadow: (radius: CGFloat, alpha: CGFloat, y: CGFloat) = (10, 0.15, 4),
    cornerRadius: CGFloat = 10
) -> some View
```

Add  foreground, background, shadow, cornerRadius to `Button` content
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

### `onNotification(_:object:perform:)`

```swift
public func onNotification(
    _ name: Notification.Name,
    object: AnyObject? = nil,
    perform action: @escaping (Notification) -> Void
) -> some View
```

Subscribe to the given notification
- Parameters:
  - name: Notification name
  - object: Object posting the notification
  - action: Action to run when received
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | Notification name |
| object | Object posting the notification |
| action | Action to run when received |

### `bottomSheet(isPresented:height:animation:thumbHidden:content:)`

```swift
public func bottomSheet<Content: View>(
    isPresented: Binding<Bool>,
    height: Height = .mid,
    animation: Animation = .easeInOut(duration: 0.3),
    thumbHidden: Bool = false,
    @ViewBuilder content: @escaping () -> Content
) -> some View
```

Adds a bottom sheet to View
- Parameters:
  - isPresented: Binding for presenting the View
  - height: Height, default .mid
  - animation: Animation
  - content: modal content
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| isPresented | Binding for presenting the View |
| height | Height, default .mid |
| animation | Animation |
| content | modal content |

### `getRect(binding:)`

```swift
public func getRect(binding: Binding<CGRect>) -> some View
```

Get the views frame in the global coordinate space
- Parameter binding: Rect binding
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| binding | Rect binding |