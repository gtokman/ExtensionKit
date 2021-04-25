**EXTENSION**

# `Timer`
```swift
public extension Timer
```

## Methods
### `schedule(delay:handler:)`

```swift
class func schedule(delay: TimeInterval, handler: @escaping () -> Void) -> CFRunLoopTimer?
```

Schedule closure to run on main run loop after delay

- Parameters:
  - delay: Delay interval
  - handler: Closure to run
- Returns: `CFRunLoopTimer`

#### Parameters

| Name | Description |
| ---- | ----------- |
| delay | Delay interval |
| handler | Closure to run |

### `schedule(repeatInterval:handler:)`

```swift
class func schedule(repeatInterval interval: TimeInterval, handler: @escaping () -> Void) -> CFRunLoopTimer?
```

 Schedule closure to run on main run loop and repeat at the interval

- Parameters:
  - interval: Interval
  - handler: Closure to run
- Returns: CFRunLoopTimer
