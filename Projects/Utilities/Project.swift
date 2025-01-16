import ProjectDescription

let project = Project(
    name: "CokeZet-Utilities",
    targets: [
        .target(
            name: "CokeZet-Utilities",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-Utilities",
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
            ]
        ),
    ]
)
