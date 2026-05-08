//
//  Module+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

extension Module {
    var name: String {
        switch self {
        case .App: projectEnvironment.targetName
        case .Features(let featureModule): featureModule.name
        case .External(let externalModule): externalModule.name
        default: "\(self)"
        }
    }
    
    var projectPath: String {
        switch self {
        case .Features(let module): return "Projects/Features/\(module.name)"
        default: return "Projects/\(name)"
        }
    }
    
    var targets: [Target] {
        switch self {
        case .App:
            [.target(moduleType: self)]
        case .DesignSystem:
            [.target(moduleType: self), .demo(moduleType: self)]
        // TODO: Feature Module
        default:
            [.target(moduleType: self)]
        }
    }
    
    var product: Product {
        switch self {
        case .App: .app
        case .DesignSystem: .staticFramework
        default: .staticLibrary
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
            .scheme(name: projectEnvironment.appName, environments: .all)
        case .DesignSystem:
            [.implements(targetName: "\(self.name)Demo")]
        default:
            []
        }
    }
    
    var additionalFiles: [FileElement]? {
        switch self {
        case .App: ["../../XCConfig/Shared.xcconfig"]
        default: nil
        }
    }
    
    var resourceSynthesizers: [ResourceSynthesizer] {
        switch self {
        case .DesignSystem: [.assets()]
        default: []
        }
    }
    
    var bundleID: String {
        if case .App = self { return "${BUNDLE_IDENTIFIER}" }
        
        let organizationName = projectEnvironment.organizationName
        let appName = projectEnvironment.appName
        
        let moduleName = switch self {
        case .Features(let module): module.name.lowercased()
        default: name.lowercased()
        }
        
        return "com.\(organizationName).\(appName).\(moduleName)"
    }
}
