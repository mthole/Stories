// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StoryData",
    platforms: [
        .iOS(.v17), // Specify iOS 17+ as the minimum deployment target
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "StoryData",
            targets: ["StoryData"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "StoryData"),
        .testTarget(
            name: "StoryDataTests",
            dependencies: ["StoryData"]
        ),
    ]
)
