
[![Release](https://img.shields.io/github/release/gtokman/extensionkit.svg)](https://github.com/gtokman/extensionkit/releases)
![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg)
[![Swift Package Manager Compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)

<img alt="Screen Shot 2021-04-24 at 3 58 58 PM" src="https://user-images.githubusercontent.com/12258850/115971376-1380be00-a516-11eb-82cd-451d7e0378fc.png">


# Documentation

## Extensions

### SwiftUI

-   [View](Documentation/Reference/ExtensionKit/extensions/View.md)
-   [Color](Documentation/Reference/ExtensionKit/extensions/Color.md)

### UIKit

-   [UIApplication](Documentation/Reference/ExtensionKit/extensions/UIApplication.md)
-   [UIButton](Documentation/Reference/ExtensionKit/extensions/UIButton.md)
-   [UIColor](Documentation/Reference/ExtensionKit/extensions/UIColor.md)
-   [UIImage](Documentation/Reference/ExtensionKit/extensions/UIImage.md)
-   [UITableView](Documentation/Reference/ExtensionKit/UITableView.md)
-   [UIView](Documentation/Reference/ExtensionKit/UIView.md)
-   [UIViewController](Documentation/Reference/ExtensionKit/UIViewController.md)

### Foundation

-   [Array](Documentation/Reference/ExtensionKit/extensions/Array.md)
-   [CFRunLoopTimer](Documentation/Reference/ExtensionKit/extensions/CFRunLoopTimer.md)
-   [Data](Documentation/Reference/ExtensionKit/extensions/Data.md)
-   [Date](Documentation/Reference/ExtensionKit/extensions/Date.md)
-   [FileManager](Documentation/Reference/ExtensionKit/extensions/FileManager.md)
-   [Int](Documentation/Reference/ExtensionKit/extensions/Int.md)
-   [NSObject](Documentation/Reference/ExtensionKit/extensions/NSObject.md)
-   [String](Documentation/Reference/ExtensionKit/extensions/String.md)
-   [Timer](Documentation/Reference/ExtensionKit/extensions/Timer.md)

### CoreGraphics

-   [CGPoint](Documentation/Reference/ExtensionKit/extensions/CGPoint.md)
-   [CGRect](Documentation/Reference/ExtensionKit/extensions/CGRect.md)

## Methods

-   [+](Documentation/Reference/ExtensionKit/methods/+(____).md)
-   [-](Documentation/Reference/ExtensionKit/methods/-(____).md)
-   [/](Documentation/Reference/ExtensionKit/methods/_(____).md)
-   [/](Documentation/Reference/ExtensionKit/methods/_(____).md)
-   [dprint(__)](Documentation/Reference/ExtensionKit/methods/dprint(__).md)
-   [sleep(duration_)](Documentation/Reference/ExtensionKit/methods/sleep(duration_).md)


## Installation

Add the url for ExtensionKit in Xcode and `Import ExtensionKit` to start using it.

```
https://github.com/gtokman/ExtensionKit.git
```


## Contact
Follow and contact me on Twitter at [@f6ary](https://www.twitter.com/f6ary).


## Contributions
If you find an issue, just [open a ticket](https://github.com/eneko/SourceDocs/issues/new)
on it. Pull requests are warmly welcome as well.

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
