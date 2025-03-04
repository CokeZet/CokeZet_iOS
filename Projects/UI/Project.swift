import ProjectDescription

let project = Project(
    name: "CokeZet-UI",
    targets: [
        .target(
            name: "CokeZet-UI",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet.CokeZet-UI",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .default,
            sources: [],
            dependencies: [
                .project(target: "CokeZet-Components", path: "../UI/CokeZet-Components"),
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
