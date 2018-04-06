// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "lablor",
    products: [
        .executable(name: "lablor", targets: ["lablor"])
    ],
    dependencies: [
        .package(url: "https://github.com/SwiftyBeaver/SwiftyBeaver.git", from: "1.4.3"),
        .package(url: "https://github.com/everlof/Argumentable.git", from: "0.0.2")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "lablor",
            dependencies: ["SwiftyBeaver", "Argumentable"]),
        .testTarget(
            name: "lablorTests",
            dependencies: ["lablor"]
        )
    ]
)
