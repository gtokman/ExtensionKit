**EXTENSION**

# `Array`
```swift
public extension Array where Element: Equatable
```

## Properties
### `removingRepeatElements`

```swift
var removingRepeatElements: Array<Element>
```

Returns an array where repeating elements of the receiver got removed.

### `body`

```swift
public var body: some View
```

Add View conformance to Array where element is View

## Methods
### `remove(_:)`

```swift
mutating func remove(_ element: Element) -> Element?
```

Removes the given element in the array.

- Parameter element: The element to be removed.
- Returns: The element got removed, or `nil` if the element doesn't exist.

#### Parameters

| Name | Description |
| ---- | ----------- |
| element | The element to be removed. |

### `init(_:)`

```swift
init<T: LosslessStringConvertible>(_ dictionary: [String: T])
```

Initialize `URLQueryItem from dictionary`
- Parameter dictionary: url parameters

#### Parameters

| Name | Description |
| ---- | ----------- |
| dictionary | url parameters |