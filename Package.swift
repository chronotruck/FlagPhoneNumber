// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "FlagPhoneNumber",
    platforms: [.macOS(.v10_10), .iOS(.v8)],
    products: [
        .library(name: "FlagPhoneNumber", targets: ["FlagPhoneNumber"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FlagPhoneNumber",
            dependencies: [],
            path: "Sources",
            sources: ["ObjcSources", "libPhoneNumber"],
            cSettings: [
                .headerSearchPath("ObjcSources"),
                .headerSearchPath("libPhoneNumber"),
            ]
        ),
        .target(
            name: "FlagPhoneNumberKit",
            dependencies: ["FlagPhoneNumber"],
            path: "Sources",
            sources: ["SwiftSources"]
        )
    ]
)
