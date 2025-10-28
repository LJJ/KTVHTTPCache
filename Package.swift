// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "KTVHTTPCache",
    platforms: [
        .iOS(.v12),
        .tvOS(.v12),
        .macOS(.v10_15),
    ],
    products: [
        .library(name: "KTVHTTPCache", targets: ["KTVHTTPCache"]),
        .library(name: "KTVHTTPCacheSwift", targets: ["KTVHTTPCacheSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/robbiehanson/CocoaAsyncSocket.git", from: "7.6.5"),
    ],
    targets: [
        .target(
            name: "KTVHTTPCache",
            dependencies: [
                .product(name: "CocoaAsyncSocket", package: "CocoaAsyncSocket"),
            ],
            path: "KTVHTTPCache",
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("CocoaHTTPServer"),
                .headerSearchPath("CocoaHTTPServer/Categories"),
                .headerSearchPath("CocoaHTTPServer/Responses"),
                .headerSearchPath("CocoaHTTPServer/Mime"),
                .headerSearchPath("Classes"),
                .headerSearchPath("Classes/KTVHCCommon"),
                .headerSearchPath("Classes/KTVHCDataStorage"),
                .headerSearchPath("Classes/KTVHCTools"),
                .headerSearchPath("Classes/KTVHCHTTPServer"),
                .headerSearchPath("Classes/KTVHCDownload"),
            ],
            linkerSettings: [
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit", .when(platforms: [.iOS, .tvOS])),
                .linkedFramework("AppKit", .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "KTVHTTPCacheSwift",
            dependencies: ["KTVHTTPCache"],
            path: "Sources/KTVHTTPCacheSwift"
        ),
    ]
)
