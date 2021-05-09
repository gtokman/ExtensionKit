**EXTENSION**

# `Publishers.Autoconnect`
```swift
extension Publishers.Autoconnect: TimerStartable where Upstream: Timer.TimerPublisher
```

## Methods
### `stop()`

```swift
public func stop()
```

Stops timer of current timer publisher instance

### `start(totalTime:)`

```swift
public func start(totalTime: TimeInterval? = nil) -> AnyPublisher<Date, Never>
```

Stops timer of current timer publisher instance after totalTime
If totalTime is nil, then continues until hard stopped
