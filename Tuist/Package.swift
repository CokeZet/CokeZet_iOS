// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "lottie-ios": .staticFramework,
            "Then": .staticFramework,
            "SnapKit": .staticFramework,
            "ModernRIBs": .staticFramework
        ]
    )
#endif

let package = Package(
    name: "CokeZet_iOS",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/airbnb/lottie-ios", from: "4.5.1"),
        .package(url: "https://github.com/devxoul/Then", branch: "master"),
        .package(url: "https://github.com/SnapKit/SnapKit", branch: "develop"),
        .package(url: "https://github.com/DevYeom/ModernRIBs", branch: "main")
    ]
)
