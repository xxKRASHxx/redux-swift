// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Redux",
    products: [
        .library(
            name: "Redux",
            targets: ["Redux"]),
        .library(
            name: "CombineRedux",
            targets: ["Redux", "CombineRedux"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "3.1.2"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.0.1"),
    ],
    targets: [
        .target(
            name: "Redux",
            dependencies: []),
        .target(
            name: "CombineRedux",
            dependencies: ["Redux"]),
        .testTarget(
            name: "ReduxTests",
            dependencies: ["Quick", "Nimble", "Redux"]),
    ],
    swiftLanguageVersions: [.v5]
)
