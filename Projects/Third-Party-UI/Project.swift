import ProjectDescription

let project = Project(
    name: "Third-Party-UI",
    targets: [
        .target(
            name: "Third-Party-UI",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.Third-Party-UI",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            dependencies: [
                .external(name: "Then"),
                .external(name: "SnapKit"),
            ]
        )
    ]
)
