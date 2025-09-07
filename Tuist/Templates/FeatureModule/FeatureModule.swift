//
//  FeatureModule.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

private let moduleNameAttribute = Template.Attribute.required("name")
private let path = "Projects/Features/\(moduleNameAttribute)"

private let projectContents = """
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(moduleType: .Features(.\(moduleNameAttribute)))
"""

private let template = Template(
    description: "A TCA feature template for a new module in presentation layer.",
    attributes: [moduleNameAttribute],
    items: [
        .string(
            path: "\(path)/Project.swift",
            contents: projectContents
        ),
        .string(
            path: "\(path)/Sources/DefaultSourceCode.swift",
            contents: "// default source code"
        )
    ]
)
