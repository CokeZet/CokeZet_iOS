import ProjectDescription

let project = Project(
    name: "CokeZet-Components",
    targets: [
        .target(
            name: "CokeZet-Components",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-Components",
            infoPlist: .default,
            sources: [
                "Sources/**",
            ],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .project(target: "Third-Party-UI", path: "../../Third-Party-UI"),
                .project(target: "CokeZet-Utilities", path: "../../Utilities"),
            ]
        ),
        .target(
            name: "Components-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet-iOS.CokeZet-Components-Test",
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "CokeZet-Components")]
        )
    ]
)
