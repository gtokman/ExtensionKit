**EXTENSION**

# `Publisher`
```swift
public extension Publisher
```

## Methods
### `debug(prefix:function:line:)`

```swift
func debug(
    prefix: String = "",
    function: String = #function,
    line: Int = #line) -> Publishers.HandleEvents<Self>
```

Debug print Publisher events
- Parameters:
  - prefix: Prefix on print statement
  - function: Function name
  - line: Line number
- Returns: Publisher

#### Parameters

| Name | Description |
| ---- | ----------- |
| prefix | Prefix on print statement |
| function | Function name |
| line | Line number |

### `receiveOnMain()`

```swift
func receiveOnMain() -> Publishers.ReceiveOn<Self, DispatchQueue>
```

Receive Output value on main thread  (DispatchQueue.main)

### `sink(result:)`

```swift
func sink(result: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable
```

A single value sink function outputs a `Result`
- Parameter result: Result<Output, Failure>
- Returns: AnyCancellable

#### Parameters

| Name | Description |
| ---- | ----------- |
| result | Result<Output, Failure> |

### `assign(to:on:)`

```swift
func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root) -> AnyCancellable
```

Assign property to object without using [weak self]
- Parameters:
  - keyPath: Property keypath
  - root: Any object
- Returns: AnyCancellable

#### Parameters

| Name | Description |
| ---- | ----------- |
| keyPath | Property keypath |
| root | Any object |