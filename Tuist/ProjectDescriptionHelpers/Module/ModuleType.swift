//
//  ModuleType.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

public enum ModuleType: Hashable {
    case App
    case Domain
    case Features(FeatureModuleType)
    case DesignSystem
    case External(ExternalModuleType)
    case Data
    case DI
}

public enum ExternalModuleType: String {
    case Swinject
}

public enum FeatureModuleType: String {
    case Root
}
