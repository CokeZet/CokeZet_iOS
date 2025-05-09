import ProjectDescription

let project = Project(
    name: "Splash-Feature",
    targets: [
        .target(
            name: "Splash-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.Splash-Feature",
            deploymentTargets: .iOS("16.0"),
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
            name: "Splash-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.Splash-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Splash-Feature")]
        )
    ]
)
