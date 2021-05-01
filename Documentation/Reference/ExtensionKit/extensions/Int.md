**EXTENSION**

# `Int`
```swift
public extension Int
```

## Properties
### `isOdd`

```swift
var isOdd: Bool
```

Whether self is an odd number

### `isEven`

```swift
var isEven: Bool
```

Whether self is an even number

### `nilIfZero`

```swift
var nilIfZero: Int?
```

Treats 0 as nil

### `string`

```swift
var string: String
```

Make the number to string

### `range`

```swift
var range: CountableRange<Int>
```

Make a range from zero to self

### `hours`

```swift
var hours: Int
```

### `minutes`

```swift
var minutes: Int
```

### `days`

```swift
var days: Int
```

### `months`

```swift
var months: Int
```

### `years`

```swift
var years: Int
```

## Methods
### `instances(of:)`

```swift
func instances<T>(of creation: @autoclosure () throws -> T) rethrows -> [T]
```

Return a number of instances

- Parameter creation: The initialization of the object
- Returns: An array containing the objects

#### Parameters

| Name | Description |
| ---- | ----------- |
| creation | The initialization of the object |

### `inRange(_:)`

```swift
func inRange(_ range: Range<Int>) -> Bool
```

Return if `self` is in the given range.

- Parameter range: Target range.
- Returns: `true` if self is in the range, otherwise `false`.

#### Parameters

| Name | Description |
| ---- | ----------- |
| range | Target range. |

### `times(block:)`

```swift
func times(block: () -> Void)
```

Calls the given block n number of times.
