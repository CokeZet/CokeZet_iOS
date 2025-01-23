import ProjectDescription

let project = Project(
    name: "CokeZet-Core",
    targets: [
        .target(
            name: "CokeZet-Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-Core",
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
