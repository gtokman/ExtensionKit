// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtensionKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ExtensionKit",
            targets: ["ExtensionKit"]),
    ],
    targets: [
        .target(
            name: "ExtensionKit",
            dependencies: []),
        .testTarget(
            name: "ExtensionKitTests",
            dependencies: ["ExtensionKit"]),
    ]
)
