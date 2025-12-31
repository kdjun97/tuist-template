//
//  ProjectEnvironment.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public struct ProjectEnvironment: @unchecked Sendable {
    public let appName: String
    public let targetName: String
    public let organizationName: String
    public let bundleIdentifier: String
    public let deploymentTargets: DeploymentTargets
    public let destination: Destinations
    public let baseSetting: SettingsDictionary
    public let defaultSettings: DefaultSettings
}

public let projectEnvironment = ProjectEnvironment(
    appName: "TuistTemplate",
    targetName: "TuistTemplate",
    organizationName: "jumy",
    bundleIdentifier: "${BUNDLE_IDENTIFIER}",
    deploymentTargets: .iOS("16.0"),
    destination: [.iPhone],
    baseSetting: [
        "OTHER_LDFLAGS": ["$(inherited) -Objc"],
        "DEBUG_INFORMATION_FORMAT": "dwarf-with-dsym",
        "OTHER_SWIFT_FLAGS": ["$(inherited)", "-enable-actor-data-race-checks"]
    ],
    defaultSettings: DefaultSettings.recommended(excluding: [
        "SWIFT_ACTIVE_COMPILATION_CONDITIONS"
    ])
)
