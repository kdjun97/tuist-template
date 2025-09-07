//
//  Configuration+Extension.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public extension Array where Element == Configuration {
    static let `default`: [Configuration] = [
        .debug(name: .dev, xcconfig: ConfigurationType.dev.xcconfigPath),
        .debug(name: .int, xcconfig: ConfigurationType.int.xcconfigPath),
        .debug(name: .qa, xcconfig: ConfigurationType.qa.xcconfigPath),
        .debug(name: .stage, xcconfig: ConfigurationType.stage.xcconfigPath),
        .debug(name: .prod, xcconfig: ConfigurationType.prod.xcconfigPath),
        .release(name: .release, xcconfig: .relativeToRoot("XCConfig/RELEASE.xcconfig"))
    ]
}

private extension ConfigurationName {
    static let dev: ConfigurationName = configuration(ConfigurationType.dev.rawValue)
    static let int: ConfigurationName = configuration(ConfigurationType.int.rawValue)
    static let qa: ConfigurationName = configuration(ConfigurationType.qa.rawValue)
    static let stage: ConfigurationName = configuration(ConfigurationType.stage.rawValue)
    static let prod: ConfigurationName = configuration(ConfigurationType.prod.rawValue)
}
