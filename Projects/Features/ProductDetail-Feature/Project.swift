import ProjectDescription

let project = Project(
    name: "ProductDetail-Feature",
    targets: [
        .target(
            name: "ProductDetail-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.ProductDetail-Feature",
            infoPlist: .default,
            sources: [
                "Sources/**",
            ],
            dependencies: [
                .project(target: "CokeZet-Core", path: "../../Core"),
                .project(target: "CokeZet-UI", path: "../../UI")
            ]
        ),
        .target(
            name: "ProductDetail-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet-iOS.ProductDetail-Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "ProductDetail-Feature")]
        )
    ]
)
