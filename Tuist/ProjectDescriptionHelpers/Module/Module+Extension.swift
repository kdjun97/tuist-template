//
//  Module+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

extension ModuleType {
    var name: String {
        switch self {
        case .App:
            projectEnvironment.targetName
        case .Domain:
            "Domain"
        case .DesignSystem:
            "DesignSystem"
        case .Features(let featureModule):
            featureModule.rawValue
        }
    }
    
    var targets: [Target] {
        switch self {
        case .App:
            [.target(moduleType: .App)]
        case .DesignSystem:
            [.target(moduleType: self), .designSystemDemo(moduleType: self)]
        // TODO: Feature Module
        default:
            [.target(moduleType: self)]
        }
    }
    
    var product: Product {
        switch self {
        case .App:
            .app
        case .DesignSystem:
            .staticFramework
        default:
            .staticLibrary
        }
    }
    
    var hasResources: Bool {
        switch self {
        case .App, .DesignSystem:
            true
        default:
            false
        }
    }
    
    var infoPlist: InfoPlist {
        switch self {
        case .App:
            .file(path: "Support/Info.plist")
        case .DesignSystem:
            .default // font 들어오면 수정
        default:
            .default
        }
    }
    
    var schemes: [Scheme] {
        switch self {
        case .App:
            .scheme(name: projectEnvironment.appName)
        case .DesignSystem:
            [.implements(targetName: "\(self.name)Demo")]
        default:
            []
        }
    }
    
    var additionalFiles: [FileElement]? {
        switch self {
        case .App:
            ["../../XCConfig/Shared.xcconfig"]
        default:
            nil
        }
    }
    
    var resourceSynthesizers: [ResourceSynthesizer] {
        switch self {
        case .DesignSystem: [.assets()]
        default: []
        }
    }
}
