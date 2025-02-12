import ProjectDescription

let project = Project(
    name: "Features",
    targets: [
        .target(
            name: "Features",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.Features",
            infoPlist: .default,
            sources: [],
            dependencies: [
                .project(target: "Nickname-Feature", path: "Nickname-Feature"),
                .project(target: "ProductDetail-Feature", path: "ProductDetail-Feature/"),
            ]
        )
    ]
)
