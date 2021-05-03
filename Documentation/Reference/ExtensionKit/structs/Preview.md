**STRUCT**

# `Preview`

```swift
public struct Preview<Content: View>: View
```

Preview content on iPhone 12 pro in light mode, iPhone 12 mini in dark mode

## Properties
### `body`

```swift
public var body: some View
```

## Methods
### `init(_:)`

```swift
public init(@ViewBuilder _ content: () -> Content)
```

Create a preview for iPhone 12 pro and iPhone 12 mini
- Parameter content: Content

#### Parameters

| Name | Description |
| ---- | ----------- |
| content | Content |