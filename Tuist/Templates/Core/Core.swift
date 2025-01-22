//
//  Example.swift
//  Manifests
//
//  Created by 김진우 on 1/16/25.
//

import ProjectDescription

let name = Template.Attribute.required("name")

let template = Template(
    description: "Core Scaffold",
    attributes: [
        name,
    ],
    items: CoreTemplate.allCases.flatMap{$0.item}
)

enum CoreTemplate: CaseIterable {
    case project
    case source
    case test
    
    var item: [Template.Item] {
        switch self {
        case .project:
            return [.file(
                path: .basePath + "/Project.swift",
                templatePath: "Project.stencil"
            )]

        case .source:
            return [
                .file(
                    path: .basePath + "/Sources/Source.swift",
                    templatePath: "../Core.stencil"
                )
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
        return "Projects/Core/CokeZet-\(name)"
    }
}
