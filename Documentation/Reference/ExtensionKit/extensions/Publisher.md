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
