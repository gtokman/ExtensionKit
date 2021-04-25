**EXTENSION**

# `Button`
```swift
public extension Button where Label == Image
```

## Methods
### `init(systemName:action:)`

```swift
init(systemName: String, action: @escaping () -> Void)
```

Initialize button with system image and trailing action
- Parameters:
  - systemName: System image name
  - action: action

#### Parameters

| Name | Description |
| ---- | ----------- |
| systemName | System image name |
| action | action |

### `init(imageName:action:)`

```swift
init(imageName: String, action: @escaping () -> Void)
```

Initialize button with local image and trailing action
- Parameters:
  - systemName: System image name
  - action: action

#### Parameters

| Name | Description |
| ---- | ----------- |
| systemName | System image name |
| action | action |