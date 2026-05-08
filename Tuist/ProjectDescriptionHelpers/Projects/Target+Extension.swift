//
//  Target+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public extension Target {
    static func target(moduleType: Module) -> Target {
        let resources: ResourceFileElements? = moduleType.hasResources ? ["Resources/**"] : nil
        let infoPlist: InfoPlist = moduleType.infoPlist
        
        return Target.implements(
            name: moduleType.name,
            product: moduleType.product,
            bundleID: moduleType.bundleID,
            resources: resources,
            infoPlist: infoPlist,
            dependencies: .dependencies(moduleType: moduleType)
        )
    }
    
    static func demo(moduleType: Module) -> Target {
        return .target(
            name: "\(moduleType.name)Demo",
            destinations: projectEnvironment.destination,
            product: .app,
            bundleId: "\(moduleType.bundleID).demo",
            deploymentTargets: projectEnvironment.deploymentTargets,
            infoPlist: .file(path: "Demo/Support/Info.plist"),
            sources: ["Demo/Sources/**"],
            dependencies: [.target(.target(moduleType: moduleType))],
            settings: .settings(configurations: .default)
        )
    }
}

// MARK: Implement
private extension Target {
    static func implements(
        name: String,
        product: Product,
        bundleID: String,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]
    ) -> Target {
        Target.target(
            name: name,
            destinations: projectEnvironment.destination,
            product: product,
            bundleId: bundleID,
            deploymentTargets: projectEnvironment.deploymentTargets,
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: resources,
            dependencies: dependencies,
            settings: .settings(
                base: projectEnvironment.baseSetting,
                configurations: .default,
                defaultSettings: projectEnvironment.defaultSettings
            )
        )
    }
}
