// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VintedGO-iOS",
    resources: [.process("Resources")],
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "VintedGO-iOS",
            targets: ["VintedGO-iOS"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "VintedGO-iOS",
            dependencies: []),
        .testTarget(
            name: "VintedGO-iOSTests",
            dependencies: ["VintedGO-iOS"]),
    ]
)
