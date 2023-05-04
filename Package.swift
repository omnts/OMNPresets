// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "OMNPresets",
                      platforms: [.macOS(.v10_13)],
                      products: [.library(name: "OMNPresets",
                                          targets: ["OMNPresets"])],
                      dependencies: [
                        // Dependencies declare other packages that this package depends on.
                        .package(url: "../OMNTools", branch: "main"),
                      ],

                      targets: [.target(name: "OMNPresets",
                                        dependencies: ["OMNTools"],
                                        path: "Sources",
                                        exclude: [])],
                      swiftLanguageVersions: [.v5])
