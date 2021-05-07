**STRUCT**

# `UserDefault`

```swift
public struct UserDefault<T>
```

```
@UserDefault("key") var myInt = 0
```

## Properties
### `key`

```swift
public let key: String
```

Key

### `wrappedValue`

```swift
public var wrappedValue: T?
```

Get the value if it existes

## Methods
### `init(_:)`

```swift
public init(_ key: String)
```

Create a new Default with Key
- Parameter key: String key

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | String key |