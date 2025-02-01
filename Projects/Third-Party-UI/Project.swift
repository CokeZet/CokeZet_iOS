import ProjectDescription

let project = Project(
    name: "Third-Party-UI",
    targets: [
        .target(
            name: "Third-Party-UI",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.Third-Party-UI",
            infoPlist: .default,
            dependencies: [
                .external(name: "Then"),
                .external(name: "SnapKit"),
            ]
        )
    ]
)
