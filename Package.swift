// swift-tools-version: 6.4
import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-birecursive",
    products: [
        .library(name: "Birecursive Macro", targets: ["Birecursive Macro"]),
        .library(name: "Birecursive Macro Core", targets: ["Birecursive Macro Core"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-molecules/swift-corecursive.git", branch: "main"),
        .package(url: "https://github.com/swift-molecules/swift-recursive.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "603.0.2"..<"604.0.0"),
    ],
    targets: [
        .target(name: "Birecursive Macro Core", dependencies: [
            .product(name: "Corecursive Macro Core", package: "swift-corecursive"),
            .product(name: "Recursive Macro Core", package: "swift-recursive"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
        ]),
        .macro(name: "Birecursive Macro Plugin", dependencies: [
            "Birecursive Macro Core",
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        ]),
        .target(name: "Birecursive Macro", dependencies: ["Birecursive Macro Plugin"]),
        .testTarget(
            name: "Birecursive Macro Tests",
            dependencies: ["Birecursive Macro"]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
