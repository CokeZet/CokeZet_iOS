import ProjectDescription

let project = Project(
    name: "Login-Feature",
    targets: [
        .target(
            name: "Login-Feature",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "CokeZet.Login-Feature",
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
            name: "Login-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.Login-Tests",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Login-Feature")]
        )
    ]
)
