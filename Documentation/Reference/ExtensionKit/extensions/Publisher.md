**EXTENSION**

# `Publisher`
```swift
public extension Publisher where Failure == Never
```

## Methods
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