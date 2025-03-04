import ProjectDescription

let project = Project(
    name: "Main-Feature",
    targets: [
        .target(
            name: "Main-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.Main-Feature",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: [
                "Sources/**",
            ],
            dependencies: [
                .project(target: "ProductDetail-Feature", path: "../ProductDetail-Feature/")
            ]
        ),
        .target(
            name: "Main-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.Main-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Main-Feature")]
        )
    ]
)
