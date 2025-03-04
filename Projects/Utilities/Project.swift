import ProjectDescription

let project = Project(
    name: "CokeZet-Utilities",
    targets: [
        .target(
            name: "CokeZet-Utilities",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-Utilities",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
