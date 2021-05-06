// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppStore",
    products: [
        .library(
            name: "AppStore",
            targets: ["AppStore"]),
    ],
    targets: [
        .target(
            name: "AppStore",
            dependencies: []),
        .testTarget(
            name: "AppStoreTests",
            dependencies: ["AppStore"]),
    ]
)
