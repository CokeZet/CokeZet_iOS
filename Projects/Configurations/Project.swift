import ProjectDescription

let project = Project(
    name: "CokeZet-Configurations",
    targets: [
        .target(
            name: "CokeZet-Configurations",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-Configurations",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
