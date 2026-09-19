// swift-tools-version: 6.4
import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "swift-birecursive",
    platforms: [.macOS(.v27), .iOS(.v27), .tvOS(.v27), .watchOS(.v27), .visionOS(.v27)],
    products: [
        .library(name: "Birecursive Macro", targets: ["Birecursive Macro"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-algebra.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-functor.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-corecursive.git", branch: "main"),
        .package(url: "https://github.com/swift-atoms/swift-recursive.git", branch: "main"),
        .package(url: "https://github.com/swiftlang/swift-syntax.git", "603.0.2"..<"604.0.0"),
    ],
    targets: [
        .target(name: "Birecursive Macro Core", dependencies: [
            .product(name: "SwiftSyntax", package: "swift-syntax"),
        ]),
        .macro(name: "Birecursive Macro Plugin", dependencies: [
            .product(name: "Type Algebra Syntax", package: "swift-algebra"),
            "Birecursive Macro Core",
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
            .product(name: "SwiftSyntax", package: "swift-syntax"),
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        ]),
        .target(name: "Birecursive Macro", dependencies: [
                .product(name: "Corecursive Macro", package: "swift-corecursive"),
                .product(name: "Recursive Macro", package: "swift-recursive"),
                .product(name: "Functor Base Macro", package: "swift-functor"),"Birecursive Macro Plugin"]),
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

// Consumer compilation must reject visibility regressions, even when other packages suppress warnings.
for target in package.targets where target.type == .test || target.name.hasSuffix("Consumer Fixtures") {
    target.swiftSettings = (target.swiftSettings ?? []) + [.treatAllWarnings(as: .error)]
}
