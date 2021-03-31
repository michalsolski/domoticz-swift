// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "DomoticzSwift",
    platforms: [
        .iOS(.v14),
        .watchOS(.v7),
        .macOS(.v11),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "DomoticzSwift",
            targets: ["DomoticzSwift"])
    ],
    dependencies: [
        .package(name: "Quick", url: "https://github.com/Quick/Quick.git", from: "3.1.2"),
        .package(name: "Nimble", url: "https://github.com/Quick/Nimble.git", from: "9.0.0")
    ],
    targets: [
        .target(
            name: "DomoticzSwift",
            dependencies: []),
        .testTarget(
            name: "DomoticzSwiftTests",
            dependencies: ["DomoticzSwift",
                           .byName(name: "Quick"),
                           .byName(name: "Nimble")])
    ]
)
