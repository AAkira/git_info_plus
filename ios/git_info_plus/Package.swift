// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "git_info_plus",
    platforms: [
        .iOS("15.0")
    ],
    products: [
        .library(name: "git-info-plus", targets: ["git_info_plus"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "git_info_plus",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
