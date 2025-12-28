//
//  ModuleType.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

public enum ModuleType: Hashable {
    case App
    case Domain
    case Presentations(PresentationModuleType)
    case DesignSystem
}

public enum ExternalModuleType: String {
    case TEMP
}

public enum PresentationModuleType: String {
    case Root
}
