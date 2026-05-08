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
