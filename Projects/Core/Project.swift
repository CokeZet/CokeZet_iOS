import ProjectDescription

let project = Project(
    name: "CokeZet-Core",
    targets: [
        .target(
            name: "CokeZet-Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-Core",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .external(name: "ModernRIBs"),
                .project(target: "CokeZet-Network", path: "../Core/Network"),
                .project(target: "CokeZet-Utilities", path: "../Utilities"),
            ]
        ),
    ]
)
