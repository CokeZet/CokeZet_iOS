import ProjectDescription

//let tuist = Tuist(
//    compatibleXcodeVersions: "16.2",
//    swiftVersion: "6.0.0",
//    plugins: [],
//    generationOptions: .options(
//        staticSideEffectsWarningTargets: .all
//    ),
//    installOptions: .options()
//)

let tuist = Tuist
    .init(project:
            .tuist(
                swiftVersion: "6.0.0",
                plugins: [],
                generationOptions: .options(
                    staticSideEffectsWarningTargets: .all
                ),
                installOptions: .options()
            )
    )
