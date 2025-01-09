import ProjectDescription

let project = Project(
    name: "UI",
    targets: [
        .target(
            name: "UI",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.UI",
            infoPlist: .default,
            sources: ["Sources/**"],
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
