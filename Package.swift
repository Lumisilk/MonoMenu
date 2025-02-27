// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MonoMenu",
    platforms: [.iOS(.v13)],
    products: [.library(name: "MonoMenu", targets: ["MonoMenu"])],
    targets: [.target(name: "MonoMenu")]
)
