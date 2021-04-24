**EXTENSION**

# `FileManager`
```swift
public extension FileManager
```

## Methods
### `fileSize(atPath:)`

```swift
func fileSize(atPath path: String) -> Int
```

Size of file at path

- Parameter path: file path
- Returns: Size in bytes

#### Parameters

| Name | Description |
| ---- | ----------- |
| path | file path |

### `folderSize(atPath:)`

```swift
func folderSize(atPath path: String) -> Int
```

Size of folder

- Parameter path: folder path
- Returns: size in bytes

#### Parameters

| Name | Description |
| ---- | ----------- |
| path | folder path |

### `directorySize(at:)`

```swift
func directorySize(at URL: URL) -> Int
```

Size of directory at URL

- Parameter URL: URL
- Returns: Size in bytes

#### Parameters

| Name | Description |
| ---- | ----------- |
| URL | URL |