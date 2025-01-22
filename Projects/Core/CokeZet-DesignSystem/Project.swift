import ProjectDescription

let project = Project(
    name: "CokeZet-DesignSystem",
    targets: [
        .target(
            name: "CokeZet-DesignSystem",
            destinations: .iOS,
            product: .framework,
            bundleId: "CokeZet-iOS.CokeZet-DesignSystem",
            infoPlist: .default,
            sources: [
                "Sources/**",
            ],
            dependencies: [
	    ]
        ),
        .target(
            name: "DesignSystem-Test",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.CokeZet-iOS.CokeZet-DesignSystem-Test",
            sources: ["Tests/**"],
            resources: [],
            dependencies: [.target(name: "CokeZet-DesignSystem")]
        )
    ]
)
