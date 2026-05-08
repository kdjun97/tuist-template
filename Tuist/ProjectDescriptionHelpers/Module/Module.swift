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

public enum ExternalModule: String {
    case Swinject
}

public enum FeatureModule: String {
    case Root
}
