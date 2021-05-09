**CLASS**

# `Subscribers.LimitedSink`

```swift
class LimitedSink<Input, Failure>: Subscriber, Cancellable where Failure: Error
```

## Methods
### `receive(subscription:)`

```swift
public func receive(subscription: Subscription)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| subscription | A subscription that represents the connection between publisher and subscriber. |

### `receive(_:)`

```swift
public func receive(_ input: Input) -> Subscribers.Demand
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| input | The published element. |

### `receive(completion:)`

```swift
public func receive(completion: Subscribers.Completion<Failure>)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| completion | A `Subscribers/Completion` case indicating whether publishing completed normally or with an error. |

### `cancel()`

```swift
public func cancel()
```
