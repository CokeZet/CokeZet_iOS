import ProjectDescription

let project = Project(
    name: "CokeZet-UI",
    targets: [
        .target(
            name: "CokeZet-UI",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-UI",
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Sources/**"],
            dependencies: [
                .external(name: "Then"),
                .external(name: "SnapKit")
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
