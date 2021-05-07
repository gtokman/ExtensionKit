**EXTENSION**

# `UIApplication`

## Properties
### `keyWindow`

```swift
var keyWindow: UIWindow?
```

Application key window

### `isConnectedToNetwork`

```swift
var isConnectedToNetwork: Bool
```

Checks if the application is connected to the internet via `SystemConfiguration`

## Methods
### `openSettings()`

```swift
func openSettings()
```

Open application settings

### `openPhone(calling:)`

```swift
func openPhone(calling number: String)
```

Opens application sheet for phonen number

### `openFacebook(name:id:)`

```swift
func openFacebook(name: String?, id: String?)
```

Find My Facebook ID: https://findmyfbid.com/
- Parameters:
  - name: Facebook name
  - id: Facebook ID

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | Facebook name |
| id | Facebook ID |

### `openInstagram(name:)`

```swift
func openInstagram(name: String?)
```

Launches the Instagram app and loads the Instagram user
- Parameter name: Instagram username

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | Instagram username |

### `openInstagram(media:)`

```swift
func openInstagram(media: String?)
```

Launches the Instagram app and loads the Instagram user
- Parameter name: Instagram username

#### Parameters

| Name | Description |
| ---- | ----------- |
| name | Instagram username |

### `openExternalMapApp(query:)`

```swift
func openExternalMapApp(query: String)
```

Open a map app with the given query. Orders: Google Map -> Apple Map

- Parameter query: The query to search on the map.

#### Parameters

| Name | Description |
| ---- | ----------- |
| query | The query to search on the map. |