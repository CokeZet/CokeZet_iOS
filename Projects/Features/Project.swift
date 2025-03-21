import ProjectDescription

let project = Project(
    name: "Features",
    targets: [
        .target(
            name: "Features",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.Features",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: [],
            dependencies: [
                .project(target: "Login-Feature", path: "Login-Feature/"),
                .project(target: "Main-Feature", path: "Main-Feature/"),
                .project(target: "MyCardSetUp-Feature", path: "MyCardSetUp-Feature/"),
                .project(target: "Nickname-Feature", path: "Nickname-Feature"),
                .project(target: "ShoppingMallSetUp-Feature", path: "ShoppingMallSetUp-Feature/"),
                .project(target: "Setting-Feature", path: "Setting-Feature/")
            ]
        )
    ]
)
