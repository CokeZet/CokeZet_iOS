import ProjectDescription

let project = Project(
    name: "Nickname-Feature",
    targets: [
        .target(
            name: "Nickname-Feature",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.Nickname-Feature",
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
            bundleId: "io.tuist.CokeZet-iOS.Nickname-Tests",
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "Nickname-Feature")]
        )
    ]
)
