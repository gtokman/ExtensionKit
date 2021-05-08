
[![Release](https://img.shields.io/github/release/gtokman/extensionkit.svg)](https://github.com/gtokman/extensionkit/releases)
![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg)
[![Swift Package Manager Compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)

<img alt="Screen Shot 2021-04-24 at 3 58 58 PM" src="https://user-images.githubusercontent.com/12258850/115971376-1380be00-a516-11eb-82cd-451d7e0378fc.png">

# Documentation

ExtensionKit includes many extensions, for getting the user location with a deterministic Combine API to a shimmer loading animation, to keyboard notification updates, and much much more. Check out the sample project or install the library with SPM to try it out.

Many extensions are things I find cumbersome in everyday iOS dev so I made a package with where I can reference the extensions anytime. Many extensions are inspired or taken from open source projects and articles from the Swift community ❤️

<br>

![2021-05-08 12 31 40](https://user-images.githubusercontent.com/12258850/117546696-a8e17f00-aff9-11eb-92e9-c351634b7a78.gif)


## Extensions

### SwiftUI

-   [Button](Documentation/Reference/ExtensionKit/extensions/Button.md)
-   [Binding](Documentation/Reference/ExtensionKit/extensions/Binding.md)
-   [Color](Documentation/Reference/ExtensionKit/extensions/Color.md)
-   [GeometryProxy](Documentation/Reference/ExtensionKit/extensions/GeometryProxy.md)
-   [Preview](Documentation/Reference/ExtensionKit/structs/Preview.md)
-   [Image](Documentation/Reference/ExtensionKit/extensions/Image.md)
-   [Shape](Documentation/Reference/ExtensionKit/extensions/Shape.md)
-   [Text](Documentation/Reference/ExtensionKit/extensions/Text.md)
-   [View](Documentation/Reference/ExtensionKit/extensions/View.md)

### Combine

-   [Publisher](Documentation/Reference/ExtensionKit/extensions/Publisher.md)

### Property Wrappers

-   [UserDefault](Documentation/Reference/ExtensionKit/structs/UserDefault.md)

### UIKit

-   [UIApplication](Documentation/Reference/ExtensionKit/extensions/UIApplication.md)
-   [UIButton](Documentation/Reference/ExtensionKit/extensions/UIButton.md)
-   [UIColor](Documentation/Reference/ExtensionKit/extensions/UIColor.md)
-   [UIImage](Documentation/Reference/ExtensionKit/extensions/UIImage.md)
-   [UITableView](Documentation/Reference/ExtensionKit/extensions/UITableView.md)
-   [UIViewController](Documentation/Reference/ExtensionKit/extensions/UIViewController.md)
-   [UIView](Documentation/Reference/ExtensionKit/extensions/UIView.md)

### Foundation

-   [Array](Documentation/Reference/ExtensionKit/extensions/Array.md)
-   [Bundle](Documentation/Reference/ExtensionKit/extensions/Bundle.md)
-   [CFRunLoopTimer](Documentation/Reference/ExtensionKit/extensions/CFRunLoopTimer.md)
-   [Collection](Documentation/Reference/ExtensionKit/extensions/Collection.md)
-   [Data](Documentation/Reference/ExtensionKit/extensions/Data.md)
-   [Date](Documentation/Reference/ExtensionKit/extensions/Date.md)
-   [DispactQueue](Documentation/Reference/ExtensionKit/extensions/DispactQueue.md)
-   [FileManager](Documentation/Reference/ExtensionKit/extensions/FileManager.md)
-   [Int](Documentation/Reference/ExtensionKit/extensions/Int.md)
-   [NSObject](Documentation/Reference/ExtensionKit/extensions/NSObject.md)
-   [UserDefaults](Documentation/Reference/ExtensionKit/extensions/UserDefaults.md)
-   [RandomAccessCollection](Documentation/Reference/ExtensionKit/extensions/RandomAccessCollection.md)
-   [String](Documentation/Reference/ExtensionKit/extensions/String.md)
-   [String.Index](Documentation/Reference/ExtensionKit/extensions/String.Index.md)
-   [Timer](Documentation/Reference/ExtensionKit/extensions/Timer.md)
-   [URL](Documentation/Reference/ExtensionKit/extensions/URL.md)

### CoreGraphics

-   [CGPoint](Documentation/Reference/ExtensionKit/extensions/CGPoint.md)
-   [CGRect](Documentation/Reference/ExtensionKit/extensions/CGRect.md)

### CoreLocation

-   [CLLocation](Documentation/Reference/ExtensionKit/extensions/CLLocation.md)
-   [CLLocationManager](Documentation/Reference/ExtensionKit/extensions/CLLocationManager.md)
-   [CLLocationCoordinate2D](Documentation/Reference/ExtensionKit/extensions/CLLocationCoordinate2D.md)

## Methods

-   [+](Documentation/Reference/ExtensionKit/methods/+(____).md)
-   [-](Documentation/Reference/ExtensionKit/methods/-(____).md)
-   [/](Documentation/Reference/ExtensionKit/methods/_(____).md)
-   [*](Documentation/Reference/ExtensionKit/methods/_(____).md)
-   [dprint(__)](Documentation/Reference/ExtensionKit/methods/dprint(__).md)
-   [sleep(duration_)](Documentation/Reference/ExtensionKit/methods/sleep(duration_).md)

## Structs

-   [Screen](Documentation/Reference/ExtensionKit/structs/Screen.md)
-   [KeyboardInfo](Documentation/Reference/ExtensionKit/structs/KeyboardInfo.md)


## Installation

Add the url for ExtensionKit in Xcode and `Import ExtensionKit` to start using it.

```
https://github.com/gtokman/ExtensionKit.git
```


## Contact
Follow and contact me on Twitter at [@f6ary](https://www.twitter.com/f6ary).


## Contributions
If you find an issue, just [open a ticket](https://github.com/gtokman/extensionkit/issues/new)
on it. Pull requests are warmly welcome as well, especially SwiftUI or AVFoundation!

**Steps**

1. Clone repo
2. **Important** pls use [semantic commit](https://github.com/conventional-changelog/commitlint#what-is-commitlint) messages (ex: `feat: your description`)
3. Add extension to [source](Sources/ExtensionKit/) directory
4. Tests are optional but add any in the [Tests](Tests) directory
5. Add documentation to the extension (opt + cmd + /) in Xcode
6. Submit a PR
7. After it merges, I'll cut a new release and update the docs

## License
ExtensionKit is licensed under the MIT license.
