// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GenStore",
    products: [
        .executable(name: "gen-store", targets: ["GenStore"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/files.git",
            from: "4.0.0"
        ),
        .package(
            url: "https://github.com/sharplet/Regex.git",
            from: "2.1.0"
        ),
        .package(
            url: "https://github.com/apple/swift-argument-parser",
            from: "1.0.1"
        )
    ],
    targets: [
        .target(
            name: "GenStore",
            dependencies: ["GenStoreCore"]
        ),
        .target(
            name: "GenStoreCore",
            dependencies: ["Files", "Regex", "ArgumentParser"]
        ),
        .testTarget(
            name: "GenStoreTests",
            dependencies: ["GenStoreCore"]
        )
    ]
)
