import ProjectDescription

let project = Project(
    name: "Setting-Feature",
    targets: [
        .target(
            name: "Setting-Feature",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "CokeZet.Setting-Feature",
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
            name: "Setting-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.Setting-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Setting-Feature")]
        )
    ]
)
