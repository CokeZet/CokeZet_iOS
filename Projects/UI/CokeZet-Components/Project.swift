import ProjectDescription

let project = Project(
    name: "CokeZet-Components",
    targets: [
        .target(
            name: "CokeZet-Components",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-Components",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: [
                "Sources/**",
            ],
            resources: [
                "Resources/**"
            ],
            dependencies: [
                .project(target: "CokeZet-DesignSystem", path: "../CokeZet-DesignSystem"),
            ]
        ),
        .target(
            name: "Components-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.CokeZet-Components-Test",
            deploymentTargets: .iOS("16.0"),
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "CokeZet-Components")]
        )
    ]
)
