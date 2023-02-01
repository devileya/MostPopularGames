// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Core",
    platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v12), .watchOS(.v5)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Core",
            targets: ["Core"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.3"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.5.0"),
        .package(url: "https://github.com/devileya/SwiftUtils", from: "1.0.8")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Core",
            dependencies: ["Swinject", "Kingfisher", "SwiftUtils"],
            resources: [.copy("Data/Local/FavoriteGameModel.xcdatamodeld")])
    ]
)
