**EXTENSION**

# `String`
```swift
public extension String
```

## Properties
### `removeHTML`

```swift
var removeHTML: String
```

Remove HTML tags from String

### `isEmail`

```swift
var isEmail: Bool
```

Is valid email

### `areNumbers`

```swift
var areNumbers: Bool
```

Are numbers 0-9

### `toInt`

```swift
var toInt: Int?
```

Cast to Int

### `toDouble`

```swift
var toDouble: Double?
```

Cast to Double

### `trimmingZeroDecimal`

```swift
var trimmingZeroDecimal: String
```

Trimming ".0"

### `addingPlusSymbol`

```swift
var addingPlusSymbol: String
```

Adding "+" at the very beginning.

### `addingMinusSymbol`

```swift
var addingMinusSymbol: String
```

Adding "-" at the very beginning.

### `uppercasingFirstLetter`

```swift
var uppercasingFirstLetter: String
```

### `lowercasingFirstLetter`

```swift
var lowercasingFirstLetter: String
```

### `isBlank`

```swift
var isBlank: Bool
```

Return `true` if self is empty or only contains white spaces and/or new lines.

### `isVisible`

```swift
var isVisible: Bool
```

Return `false` if self is empty or only contains white spaces and/or new lines.

### `nilIfBlank`

```swift
var nilIfBlank: String?
```

Return `nil` if `self.isBlank` is `true`.

## Methods
### `trim()`

```swift
func trim() -> String
```

Trim white space and new lines

### `layoutSize(with:)`

```swift
func layoutSize(with font: UIFont) -> CGSize
```

Returns the CGSize that the string being layout on screen.

- Parameter font: The given font.
- Returns: The result CGSize.

#### Parameters

| Name | Description |
| ---- | ----------- |
| font | The given font. |

### `advanceNumberValue(step:)`

```swift
mutating func advanceNumberValue(step: Int = 1)
```

Cast as Int and add the given value. No changes if casting fails.

### `isOldAppVersion(comparedWith:)`

```swift
func isOldAppVersion(comparedWith aVersion: String) -> Bool
```

Comparing app versions. Returns `true` if self is `1.1.0` and the given value is `1.2.0`.
- Parameter aVersion: Another version.
- Returns: `true`  if the give version is newer than self.

#### Parameters

| Name | Description |
| ---- | ----------- |
| aVersion | Another version. |

### `treatsVisuallyEmptyAsNil()`

```swift
func treatsVisuallyEmptyAsNil() -> String?
```

### `slice(from:to:)`

```swift
func slice(from: String, to: String) -> String?
```

Get subscring from created range
- Parameters:
  - from: from String
  - to: to String
- Returns: String

#### Parameters

| Name | Description |
| ---- | ----------- |
| from | from String |
| to | to String |