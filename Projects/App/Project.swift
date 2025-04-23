import ProjectDescription

let project = Project(
    name: "CokeZet-App",
    targets: [
        .target(
            name: "CokeZet-App",
            destinations: .iOS,
            product: .app,
            bundleId: "CokeZet.CokeZet-App",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen",
                    "ITSAppUsesNonExemptEncryption": false,
                    "NSAppTransportSecurity": .dictionary([ // ATS 설정 예시
                        "NSAllowsArbitraryLoads": .boolean(true)
                    ]),
                ]
            ),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            entitlements: "CokeZet-App.entitlements",
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
