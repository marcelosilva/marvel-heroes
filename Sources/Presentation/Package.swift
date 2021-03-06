// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Presentation",
            targets: ["Presentation"]),
    ],
    dependencies: [
        .package(path: "../App"),
        .package(
            url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
            from: "1.9.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Presentation",
            dependencies: [
                "App"
            ],
            path: "Sources",
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "PresentationTests",
            dependencies: [
                "Presentation",
                "App",
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing")
            ],
            path: "Tests",
            exclude: [
                "PresentationTests/CharacterListTests/__Snapshots__",
                "PresentationTests/CharacterDetailTests/__Snapshots__"
            ]
        ),
    ]
)
