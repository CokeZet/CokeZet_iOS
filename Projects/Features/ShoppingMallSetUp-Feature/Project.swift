import ProjectDescription

let project = Project(
    name: "ShoppingMallSetUp-Feature",
    targets: [
        .target(
            name: "ShoppingMallSetUp-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.ShoppingMallSetUp-Feature",
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
            name: "ShoppingMallSetUp-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet-iOS.ShoppingMallSetUp-Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "ShoppingMallSetUp-Feature")]
        )
    ]
)
