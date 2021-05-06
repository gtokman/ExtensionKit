### `dprint(_:_:)`

```swift
public func dprint(_ item: @autoclosure () -> Any, _ event: PrintEvent = .d)
```

Swift still calls `print()` and/or `debugPrint()` in shipped apps.
We use a method described in onevcat's post (https://onevcat.com/2016/02/swift-performance/)
to optimaze the performance.

- Parameter item: items to print

#### Parameters

| Name | Description |
| ---- | ----------- |
| item | items to print |