**EXTENSION**

# `NSObject`
```swift
public extension NSObject
```

## Properties
### `className`

```swift
var className: String
```

Return class name.

## Methods
### `exchangeImplementations(originalSelector:swizzledSelector:)`

```swift
class func exchangeImplementations(originalSelector: Selector, swizzledSelector: Selector)
```

Exchange two implementations of the given selectors, aka method swizzling.

- Parameters:
  - originalSelector: The original selector.
  - swizzledSelector: Another selector.

#### Parameters

| Name | Description |
| ---- | ----------- |
| originalSelector | The original selector. |
| swizzledSelector | Another selector. |

### `printDeinitMessage()`

```swift
final func printDeinitMessage()
```

Print the deinitialization message of self.
