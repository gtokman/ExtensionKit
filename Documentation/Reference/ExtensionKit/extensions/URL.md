**EXTENSION**

# `URL`
```swift
public extension URL
```

## Methods
### `init(_:)`

```swift
init(_ string: StaticString)
```

Create URL from String
- Parameter string: URL string

#### Parameters

| Name | Description |
| ---- | ----------- |
| string | URL string |

### `init(_:path:parameters:)`

```swift
init?<T: LosslessStringConvertible>(
    _ baseUrl: StaticString,
    path: StaticString = "",
    parameters: [String: T] = [:]
)
```

Create URL from baseUrl, path, and parameters
- Parameters:
  - baseUrl: base URL including the host (https)
  - path: url path default, empty string
  - parameters: parameters, key/value pair

#### Parameters

| Name | Description |
| ---- | ----------- |
| baseUrl | base URL including the host (https) |
| path | url path default, empty string |
| parameters | parameters, key/value pair |