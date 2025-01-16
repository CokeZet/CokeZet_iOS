import ProjectDescription

let project = Project(
    name: "CokeZet-Network",
    targets: [
        .target(
            name: "CokeZet-Network",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-Network",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
