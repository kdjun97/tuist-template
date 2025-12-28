// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [:],
        baseSettings: .settings(
            configurations: [
                .debug(name: ConfigurationType.dev.name),
                .debug(name: ConfigurationType.int.name),
                .debug(name: ConfigurationType.qa.name),
                .debug(name: ConfigurationType.stage.name),
                .debug(name: ConfigurationType.prod.name),
                .release(name: .release)
            ]
        ),
    )
#endif

let package = Package(
    name: "TuistTemplate",
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1")
    ]
)

