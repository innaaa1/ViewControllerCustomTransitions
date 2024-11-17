// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewControllerCustomTransitions",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ViewControllerCustomTransitions",
            targets: ["ViewControllerCustomTransitions"]),
    ],
//    dependencies: [
//           
//            .package(url: "https://github.com/realm/SwiftLint", from: "0.46.0")
//        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ViewControllerCustomTransitions",
            linkerSettings: [
                .linkedFramework("UIKit")
            ]),
        
        .testTarget(
            name: "ViewControllerCustomTransitionsTests",
            dependencies: ["ViewControllerCustomTransitions"]),
    ]
)
