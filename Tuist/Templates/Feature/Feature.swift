//
//  Example.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ProjectDescription

let name = Template.Attribute.required("name")

let template = Template(
    description: "Feature Scaffold",
    attributes: [
        name,
    ],
    items: FeatureTemplate.allCases.flatMap{$0.item}
)

enum FeatureTemplate: CaseIterable {
    case project
    case modernRibs
    case test
    
    var item: [Template.Item] {
        switch self {
        case .project:
            return [.file(
                path: .basePath + "/Project.swift",
                templatePath: "Project.stencil"
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
        }
        
    }
}

extension String {
    static var basePath: Self {
        return "Projects/Features/\(name)-Feature"
    }
}
