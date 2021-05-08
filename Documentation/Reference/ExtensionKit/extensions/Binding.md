**EXTENSION**

# `Binding`
```swift
public extension Binding where Value: Equatable
```

## Methods
### `onChange(_:)`

```swift
func onChange(_ action: @escaping (Value) -> Void) -> Self
```

```
Toggle(
    "Foo",
    isOn: $foo.onChange {
        bar.isEnabled = $0
    }
)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| action | Action to run |