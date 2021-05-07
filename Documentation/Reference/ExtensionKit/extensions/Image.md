**EXTENSION**

# `Image`
```swift
public extension Image
```

## Methods
### `init(_:defaultImage:)`

```swift
init(_ name: String, defaultImage: String)
```

Initialize with a default image
- Parameters:
  - name: primary image name
  - defaultImage: default image name

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | primary image name |
| defaultImage | default image name |

### `init(_:defaultSystemImage:)`

```swift
init(_ name: String, defaultSystemImage: String)
```

Initialize with default system image
- Parameters:
  - name: primary image name
  - defaultSystemImage: default image name

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | primary image name |
| defaultSystemImage | default image name |

### `icon(with:)`

```swift
func icon(with size: CGSize) -> some View
```

Create a resizable image with CGSize
- Parameter size: CGSize
- Returns: View

#### Parameters

| Name | Description |
| ---- | ----------- |
| size | CGSize |