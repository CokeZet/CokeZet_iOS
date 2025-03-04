import ProjectDescription

let project = Project(
    name: "CokeZet-Network",
    targets: [
        .target(
            name: "CokeZet-Network",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "CokeZet.CokeZet-Network",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
