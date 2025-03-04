import ProjectDescription

let project = Project(
    name: "CokeZet-DesignSystem",
    targets: [
        .target(
            name: "CokeZet-DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-DesignSystem",
            deploymentTargets: .iOS("16.0"),
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
            name: "DesignSystem-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet.CokeZet-DesignSystem-Test",
            deploymentTargets: .iOS("16.0"),
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "CokeZet-DesignSystem")]
        )
    ]
)
