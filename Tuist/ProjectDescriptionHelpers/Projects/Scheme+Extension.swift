//
//  Scheme+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

extension Array where Element == Scheme {
    static func scheme(name: String) -> [Scheme] {
        let deployTargets: [ConfigurationType] = ConfigurationType.allCases
        
        return deployTargets.map {
            return .implements(
                targetName: name,
                configurationType: $0
            )
        }
    }
}

extension Scheme {
    static func implements(
        targetName: String,
        configurationType: ConfigurationType? = nil
    ) -> Scheme {
        guard let configurationType else {
            return .scheme(
                name: targetName,
                shared: true,
                buildAction: .buildAction(targets: ["\(targetName)"]),
                runAction: .runAction(configuration: ConfigurationType.dev.name)
            )
        }
        
        let schemeName = switch configurationType {
        case .prod:
            targetName
        default:
            "\(targetName)-\(configurationType.rawValue)"
        }
        
        return Scheme.scheme(
            name: schemeName,
            shared: true,
            buildAction: .buildAction(targets: ["\(targetName)"]),
            runAction: .runAction(configuration: configurationType.name),
            archiveAction: .archiveAction(configuration: configurationType.name),
            profileAction: .profileAction(configuration: configurationType.name),
            analyzeAction: .analyzeAction(configuration: configurationType.name)
        )
    }
}
