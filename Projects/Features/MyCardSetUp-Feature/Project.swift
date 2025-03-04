import ProjectDescription

let project = Project(
    name: "MyCardSetUp-Feature",
    targets: [
        .target(
            name: "MyCardSetUp-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.MyCardSetUp-Feature",
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
            name: "MyCardSetUp-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.MyCardSetUp-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "MyCardSetUp-Feature")]
        )
    ]
)
