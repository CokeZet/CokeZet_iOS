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
            sources: ["Sources/**"],
            dependencies: [
                .project(target: "Core", path: "../Core"),
                .project(target: "UI", path: "../UI")
            ]
        ),
        
//            .target(
//                name: "CokeZet_iOSTests",
//                destinations: .iOS,
//                product: .unitTests,
//                bundleId: "io.tuist.CokeZet-iOSTests",
//                infoPlist: .default,
//                sources: ["Tests/**"],
//                resources: [],
//                dependencies: [.target(name: "Features")]
//            )
    ]
)
