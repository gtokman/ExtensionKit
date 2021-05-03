**EXTENSION**

# `Bundle`
```swift
public extension Bundle
```

## Properties
### `versionNumber`

```swift
var versionNumber: String
```

Version number via -  CFBundleShortVersionString

### `buildNumber`

```swift
var buildNumber: String
```

Build number via -  CFBundleVersion

## Methods
### `decode(_:from:dateDecodingStrategy:keyDecodingStrategy:)`

```swift
func decode<T: Decodable>(
    _ type: T.Type, from file: String,
    dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys
) -> Deferred<Future<T, Error>>
```

Load model type from bundle resource
- Parameters:
  - type: Type to load
  - file: File name
  - dateDecodingStrategy: date decoding strategy
  - keyDecodingStrategy: key decoding strategy
- Returns: Future

#### Parameters

| Name | Description |
| ---- | ----------- |
| type | Type to load |
| file | File name |
| dateDecodingStrategy | date decoding strategy |
| keyDecodingStrategy | key decoding strategy |