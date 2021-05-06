// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presenter",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "Presenter",
            targets: ["Presenter"]),
        .library(
            name: "UIKitPresenter",
            targets: ["UIKitPresenter"]),
    ],
    targets: [
        .target(
            name: "Presenter",
            dependencies: []),
        .target(
            name: "UIKitPresenter",
            dependencies: ["Presenter"]),
        .testTarget(
            name: "PresenterTests",
            dependencies: ["Presenter"]),
    ]
)
