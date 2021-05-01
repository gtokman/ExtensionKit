**EXTENSION**

# `Date`
```swift
public extension Date
```

## Properties
### `year`

```swift
var year: Int
```

Returns the year from the date.

### `month`

```swift
var month: Int
```

Returns month as `Int` starting from `1...12`.

### `week`

```swift
var week: Int
```

Returns week as `Int` starting from 1...52

### `weekday`

```swift
var weekday: Int
```

### `weekOfMonth`

```swift
var weekOfMonth: Int
```

### `day`

```swift
var day: Int
```

### `hour`

```swift
var hour: Int
```

### `minute`

```swift
var minute: Int
```

### `second`

```swift
var second: Int
```

### `nanos`

```swift
var nanos: Int
```

### `yesterday`

```swift
var yesterday: Date
```

### `today`

```swift
var today: Date
```

### `tomorrow`

```swift
var tomorrow: Date
```

### `dayAfter`

```swift
var dayAfter: Date
```

### `dayBefore`

```swift
var dayBefore: Date
```

### `isLastDayOfMonth`

```swift
var isLastDayOfMonth: Bool
```

### `startOfDay`

```swift
var startOfDay: Date
```

Start of current day

### `endOfDay`

```swift
var endOfDay: Date
```

End of current day

## Methods
### `adjust(_:offset:)`

```swift
func adjust(_ type: Calendar.Component, offset: Int) -> Date
```

Offset component by amount
- Parameters:
  - type: Component
  - offset: Offset to add
- Returns: Date

#### Parameters

| Name | Description |
| ---- | ----------- |
| type | Component |
| offset | Offset to add |

### `toRelativeFormat(currentDate:numericDates:)`

```swift
func toRelativeFormat(
    currentDate: Date = Date(),
    numericDates: Bool = true
) -> String
```

Get relative String back from Date ex: 1 year ago, 1 month ago ...
- Parameters:
  - currentDate: Current Date
  - numericDates: Display the numeric value in string ex: 1 year ago vs Last year
- Returns: String

#### Parameters

| Name | Description |
| ---- | ----------- |
| currentDate | Current Date |
| numericDates | Display the numeric value in string ex: 1 year ago vs Last year |