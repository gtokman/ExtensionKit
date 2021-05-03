**EXTENSION**

# `UserDefaults`
```swift
public extension UserDefaults
```

## Methods
### `getCodable(forKey:)`

```swift
func getCodable<T: Codable>(forKey key: String) -> T?
```

Get `Codable` model from user defaults
- Parameter key: String key
- Returns: Model

#### Parameters

| Name | Description |
| ---- | ----------- |
| key | String key |

### `setCodable(value:forKey:)`

```swift
func setCodable<T: Codable>(value: T, forKey key: String)
```

Set `Codable` mode to user defaults
- Parameters:
  - value: Model
  - key: String key

#### Parameters

| Name | Description |
| ---- | ----------- |
| value | Model |
| key | String key |