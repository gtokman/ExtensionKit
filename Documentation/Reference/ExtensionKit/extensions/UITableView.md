**EXTENSION**

# `UITableView`

## Properties
### `isEmpty`

```swift
var isEmpty: Bool
```

Zero rows in all sections

## Methods
### `reloadCell(_:with:)`

```swift
func reloadCell(_ cell: UITableViewCell, with animation: UITableView.RowAnimation)
```

Reload cell  at index path
- Parameters:
  - cell: cell
  - animation: animation

#### Parameters

| Name | Description |
| ---- | ----------- |
| cell | cell |
| animation | animation |

### `scrollToBottom(position:animated:)`

```swift
func scrollToBottom(position: UITableView.ScrollPosition = .bottom, animated: Bool = true)
```

Scroll to last index in last section
- Parameters:
  - position: position
  - animated: animated

#### Parameters

| Name | Description |
| ---- | ----------- |
| position | position |
| animated | animated |