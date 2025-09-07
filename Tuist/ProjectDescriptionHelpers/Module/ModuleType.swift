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
}

public enum ExternalModuleType: String {
    case TCA // 임시
}

public enum FeatureModuleType: String {
    case Root
}
