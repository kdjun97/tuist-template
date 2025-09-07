//
//  ConfigurationType.swift
//  ProjectDescriptionHelpers
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public enum ConfigurationType: String, CaseIterable {
    case dev = "DEV"
    case int = "INT"
    case qa = "QA"
    case stage = "STAGE"
    case prod = "PROD"

    public var name: ConfigurationName {
        ConfigurationName.configuration(self.rawValue)
    }
    
    public var xcconfigPath: Path {
        return .relativeToRoot("XCConfig/\(rawValue).xcconfig")
    }
}
