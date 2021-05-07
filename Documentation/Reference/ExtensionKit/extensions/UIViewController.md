**EXTENSION**

# `UIViewController`

## Properties
### `classNameValue`

```swift
var classNameValue: String
```

ViewController class name

### `titleColor`

```swift
var titleColor: UIColor?
```

NavigationBar tint color

### `titleFont`

```swift
var titleFont: UIFont?
```

NavigationBar font

### `viewIsVisible`

```swift
var viewIsVisible: Bool
```

Is view loaded and in window

### `automaticallyHideKeyboardWhenViewTapped`

```swift
var automaticallyHideKeyboardWhenViewTapped: Bool
```

Should hide keyboard on view tap

### `bottomToolBar`

```swift
var bottomToolBar: UIView?
```

Add a bottom tool bar to view controller

### `hidesNavigationBarBackgroundWhenVisible`

```swift
var hidesNavigationBarBackgroundWhenVisible: Bool
```

Hide navigation bar background when visible

### `navigationBarHeight`

```swift
var navigationBarHeight: CGFloat
```

Navigation bar height

### `tabBarHeight`

```swift
var tabBarHeight: CGFloat
```

Tab bar height

## Methods
### `addChild(viewController:in:)`

```swift
func addChild(viewController: UIViewController, in view: UIView)
```

Adds a child viewController to the current controller view
- Parameter viewController: The child view

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | The child view |

### `removeChild(viewController:)`

```swift
func removeChild(viewController: UIViewController)
```

Removes a child viewController from current
- Parameter viewController: The child view controller to remove

#### Parameters

| Name | Description |
| ---- | ----------- |
| viewController | The child view controller to remove |

### `combine(models:into:newViewGeneration:using:remainingViews:)`

```swift
class func combine<Model, View>(models: [Model], into views: inout [View], newViewGeneration: () -> View, using operation: (Model, View) -> Void, remainingViews: (ArraySlice<View>) -> Void)
```

Combine an array of models and an array of views.

- Parameters:
  - models: The models as data source.
  - views: The views in need of loading data. Note that this is an inout parameters.
  - newViewGeneration: The function to generate new views, which would immediately be appended into `views`.
  - operation: The main operation that combine each model and view together.
  - remainingViews: The handler responsible for dealing with the rest of unused views.

#### Parameters

| Name | Description |
| ---- | ----------- |
| models | The models as data source. |
| views | The views in need of loading data. Note that this is an inout parameters. |
| newViewGeneration | The function to generate new views, which would immediately be appended into `views`. |
| operation | The main operation that combine each model and view together. |
| remainingViews | The handler responsible for dealing with the rest of unused views. |

### `showSystemAlert(title:message:confirmTitle:confirmHandler:cancelTitle:cancelHandler:)`

```swift
func showSystemAlert(
    title: String?,
    message: String? = nil,
    confirmTitle: String? = nil,
    confirmHandler: (() -> Void)? = nil,
    cancelTitle: String = "Cancel",
    cancelHandler: (() -> Void)? = nil)
```

Present system alert

- Parameters:
  - title: Title
  - message: Message
  - confirmTitle: Confirm button title
  - confirmHandler: Confirm handler to run on press
  - cancelTitle: Cancel button title
  - cancelHandler: Cancel handler to run on press

#### Parameters

| Name | Description |
| ---- | ----------- |
| title | Title |
| message | Message |
| confirmTitle | Confirm button title |
| confirmHandler | Confirm handler to run on press |
| cancelTitle | Cancel button title |
| cancelHandler | Cancel handler to run on press |

### `showSystemDistructiveAlert(title:message:destructiveTitle:destructiveHandler:cancelTitle:cancelHandler:)`

```swift
func showSystemDistructiveAlert(
    title: String?,
    message: String? = nil,
    destructiveTitle: String?,
    destructiveHandler: (() -> Void)?,
    cancelTitle: String?,
    cancelHandler: (() -> Void)? = nil)
```

Present system alert with distructive primary action

- Parameters:
  - title: Title
  - message: Message
  - confirmTitle: Confirm button title
  - confirmHandler: Confirm handler to run on press
  - cancelTitle: Cancel button title
  - cancelHandler: Cancel handler to run on press

#### Parameters

| Name | Description |
| ---- | ----------- |
| title | Title |
| message | Message |
| confirmTitle | Confirm button title |
| confirmHandler | Confirm handler to run on press |
| cancelTitle | Cancel button title |
| cancelHandler | Cancel handler to run on press |

### `showSystemActionSheet(title:message:validActions:)`

```swift
func showSystemActionSheet(title: String?, message: String?, validActions: (String?, (() -> Void)?)...)
```

Present action sheet

- Parameters:
  - title: Title
  - message: Message
  - actions: Actions in the sheet

#### Parameters

| Name | Description |
| ---- | ----------- |
| title | Title |
| message | Message |
| actions | Actions in the sheet |

### `resignTextFieldToHideKeyboard(_:)`

```swift
@IBAction func resignTextFieldToHideKeyboard(_ sender: AnyObject)
```

Resign keyboard

### `getCurrentViewController(base:)`

```swift
class func getCurrentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController?
```

Get the current visible view controller by crawling the view controller heirarchy

- Parameter base: `UIViewController` to search
- Returns: Current `UIViewController`

#### Parameters

| Name | Description |
| ---- | ----------- |
| base | `UIViewController` to search |

### `popFromNavigationStack()`

```swift
func popFromNavigationStack()
```

Pop view controller from nav stack

### `addDismissNavigationItem(localizedTitle:image:)`

```swift
func addDismissNavigationItem(localizedTitle: String = "Dismiss", image: UIImage? = nil)
```

Add dismiss `UIBarButtonItem` naviation item

### `dismissSelf(_:)`

```swift
@objc func dismissSelf(_ sender: Any)
```

### `pushSafariViewController(urlString:entersReaderIfAvailable:)`

```swift
func pushSafariViewController(urlString: String, entersReaderIfAvailable: Bool = false)
```
