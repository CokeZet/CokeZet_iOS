import ProjectDescription

let project = Project(
    name: "App",
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "CokeZet-iOS.App",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                    "UIApplicationSceneManifest": [
                        "UIApplicationSupportsMultipleScenes": false,
                        "UISceneConfigurations": [
                            "UIWindowSceneSessionRoleApplication": [
                                [
                                    "UISceneConfigurationName": "Default Configuration",
                                    "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                                ],
                            ]
                        ]                            ],
                ]                   ),
            sources: ["Sources/**"],
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
