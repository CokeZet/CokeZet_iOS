import ProjectDescription

let project = Project(
    name: "Nickname-Feature",
    targets: [
        .target(
            name: "Nickname-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.Nickname-Feature",
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
            name: "Nickname-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.Nickname-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Nickname-Feature")]
        )
    ]
)
