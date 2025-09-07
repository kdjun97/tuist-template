//
//  Project+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public extension Project {
    static func module(moduleType: ModuleType) -> Project {
        Project.implements(
            name: moduleType.name,
            targets: moduleType.targets,
            schemes: moduleType.schemes,
            additionalFiles: moduleType.additionalFiles
        )
    }
}

// MARK: Implement
public extension Project {
    static func implements(
        name: String,
        targets: [Target],
        schemes: [Scheme],
        additionalFiles: [FileElement]? = nil
    ) -> Project {
        Project(
            name: name,
            organizationName: projectEnvironment.organizationName,
            options: .options(
                automaticSchemesOptions: .disabled
            ),
            settings: .settings(
                base: projectEnvironment.baseSetting,
                configurations: .default,
                defaultSettings: projectEnvironment.defaultSettings
            ),
            targets: targets,
            schemes: schemes,
            additionalFiles: additionalFiles ?? [],
            resourceSynthesizers: [] // design System 에서 사용 예정
        )
    }
}
