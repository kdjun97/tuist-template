//
//  Module.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

public enum Module: Hashable {
    case App
    case Domain
    case Features(FeatureModule)
    case DesignSystem
    case External(ExternalModule)
    case Data
    case DI
    case MicroFeature(MicroFeatureModule)
}

public enum ExternalModule {
    case Swinject
    
    var name: String {
        switch self {
        default: "\(self)"
        }
    }
}

public enum FeatureModule {
    case Root
    
    var name: String {
        switch self {
        default: "\(self)"
        }
    }
}

public enum MicroFeatureModule {
    case Auth
    
    var name: String {
        switch self {
        default: "\(self)"
        }
    }
    
    var interfaceName: String { "\(name)Interface" }
    var testingName: String { "\(name)Testing" }
    var testsName: String { "\(name)Tests" }
    var demoName: String { "\(name)Demo" }
    
    var bundleID: String {
        let organizationName = projectEnvironment.organizationName
        let appName = projectEnvironment.appName
        return "com.\(organizationName).\(appName).\(name.lowercased())"
    }
    
    var path: String {
        switch self {
        case .Auth: "Projects/Features/Auth"
        }
    }
}
