import ProjectDescription

let project = Project(
    name: "CokeZet-App",
    targets: [
        .target(
            name: "CokeZet-App",
            destinations: .iOS,
            product: .app,
            bundleId: "CokeZet-iOS.CokeZet-App",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "Features", path: "../Features"),
            ]
        ),
        
//        .target(
//            name: "CokeZet_iOSTests",
//            destinations: .iOS,
//            product: .unitTests,
//            bundleId: "io.tuist.CokeZet-iOSTests",
//            infoPlist: .default,
//            sources: ["Tests/**"],
//            resources: [],
//            dependencies: [.target(name: "App")]
//        ),
    ]
)
