//
//  DemoApp.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ProjectDescription

let name = Template.Attribute.required("name")
let features = Template.Attribute.required("features")

let template = Template(
    description: "DemoApp Scaffold",
    attributes: [
        name,
        features
    ],
    items: FeatureTemplate.allCases.flatMap{$0.item}
)

enum FeatureTemplate: CaseIterable {
    case project
    case appDelegate
    case modernRibs
    case test
    case launchScreen
    
    var item: [Template.Item] {
        switch self {
        case .project:
            return [.file(
                path: .basePath + "/Project.swift",
                templatePath: "Project.stencil"
            )]
            
        case .appDelegate:
            return [.file(
                path: .basePath + "/App/\(name)AppDelegate.swift",
                templatePath: "../AppDelegate.stencil"
            )]
            
        case .modernRibs:
            return [
                .file(
                    path: .basePath + "/Sources/\(name)ViewController.swift",
                    templatePath: "../ViewController.stencil"
                ),
                .file(
                    path: .basePath + "/Sources/\(name)Builder.swift",
                    templatePath: "../Builder.stencil"
                ),
                .file(
                    path: .basePath + "/Sources/\(name)Interactor.swift",
                    templatePath: "../Interactor.stencil"
                ),
                .file(
                    path: .basePath + "/Sources/\(name)Router.swift",
                    templatePath: "../Router.stencil"
                ),
            ]
            
        case .test:
            return [
                .file(
                    path: .basePath + "/Tests/\(name)Tests.swift",
                    templatePath: "../Test.stencil"
                )
            ]
        case .launchScreen:
            return [
                .file(path: .basePath + "/Resources/LaunchScreen.storyboard",
                      templatePath: "LaunchScreen.stencil"
                     ),
            ]
        }
        
    }
}

extension String {
    static var basePath: Self {
        return "Projects/DemoApps/\(name)-DemoApp"
    }
}
