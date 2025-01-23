import ProjectDescription

let project = Project(
    name: "CokeZet-Network",
    targets: [
        .target(
            name: "CokeZet-Network",
            destinations: .iOS,
            product: .staticFramework,
            bundleId: "CokeZet-iOS.CokeZet-Network",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
