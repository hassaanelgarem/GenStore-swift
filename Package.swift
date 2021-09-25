// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HGStringStoreGenerator",
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/files.git",
            from: "4.0.0"
        ),
        .package(
            url: "https://github.com/sharplet/Regex.git",
            from: "2.1.0"
        )
    ],
    targets: [
        .target(
            name: "HGStringStoreGenerator",
            dependencies: ["HGStringStoreGeneratorCore"]
        ),
        .target(
            name: "HGStringStoreGeneratorCore",
            dependencies: ["Files", "Regex"]
        ),
        .testTarget(
            name: "HGStringStoreGeneratorTests",
            dependencies: ["HGStringStoreGeneratorCore"]
        )
    ]
)
