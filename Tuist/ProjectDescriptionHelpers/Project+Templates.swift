import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

public enum AppConfiguration {
    public static let APP_VERSION = "1.0.0"
    public static let DEPLOYMENT_TARGET = "15.0"
    public static let SWIFT_VERSION = "5.8"
}

public enum AppSetting {
    public static let appName = "GongGanGam"
    public static let bundleIdPrefix = "com.tnzkm"
    public static let deploymentTarget: DeploymentTarget = .iOS(
        targetVersion: AppConfiguration.DEPLOYMENT_TARGET,
        devices: [.iphone],
        supportsMacDesignedForIOS: false
    )
}

public extension Project {
    
    static let organizationName = "tnzkm"
    
    static func makeProject(
        name: String,
        packages: [Package] = [],
        targets: [Target]
    ) -> Project {
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: .settings(configurations: [
                .debug(name: "Debug", xcconfig: .relativeToRoot("Config/Debug.xcconfig")),
                .release(name: "Release", xcconfig: .relativeToRoot("Config/Release.xcconfig"))
            ]),
            targets: targets
        )
    }
    // MARK: - DynamicFramework
    static func makeFrameworkTarget(moduleName: String = "", targetName: String, platform: Platform, dependencies: [TargetDependency], useResources: Bool = false) -> Target {
        
        return Target(
            name: moduleName + targetName,
            platform: platform,
            product: .framework,
            bundleId: "\(AppSetting.bundleIdPrefix).\(moduleName)\(targetName)",
            infoPlist: .default,
            sources: ["Sources/**/*.swift"],
            resources: useResources ? ["Resources/**"] : nil,
            dependencies: dependencies
        )
    }
    
    // MARK: - TestTarget
    static func makeTestTarget(name: String, platform: Platform, dependencies: [TargetDependency]) -> Target {
        return Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: AppSetting.bundleIdPrefix + ".\(name)",
            deploymentTarget: AppSetting.deploymentTarget,
            infoPlist: .default,
            sources: ["./Tests/**"],
            dependencies: dependencies
        )
    }
    
    // MARK: - StaticFramework
    static func makeStaticFrameworkTarget(name: String, platform: Platform = .iOS, iOSTargetVersion: String, infoPlist: [String: Plist.Value] = [:] ,dependencies: [TargetDependency] = []) -> Target {
        return Target(
            name: name,
            platform: platform,
            product: .staticFramework,
            bundleId: AppSetting.bundleIdPrefix + ".\(name)",
            deploymentTarget: AppSetting.deploymentTarget,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: dependencies
        )
    }
    
    // MARK: - AppTarget
    static func makeAppTarget(name: String, platform: Platform, infoPlist: [String: Plist.Value] = [:], dependencies: [TargetDependency] = []) -> Target {
        return Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: AppSetting.bundleIdPrefix + ".\(name)",
            deploymentTarget: AppSetting.deploymentTarget,
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Example/Sources/**"],
            resources: ["Example/Resources/**"],
            dependencies: [.target(name: name)] + dependencies
        )
    }
    
    static func makeAppTarget(name: String, platform: Platform, infoPlist: String, dependencies: [TargetDependency] = []) -> Target {
        return Target(
            name: name,
            platform: platform,
            product: .app,
            bundleId: AppSetting.bundleIdPrefix + ".\(name)",
            deploymentTarget: AppSetting.deploymentTarget,
            infoPlist: InfoPlist(stringLiteral: infoPlist),
            sources: ["Example/Sources/**"],
            resources: ["Example/Resources/**"],
            dependencies: [.target(name: name)] + dependencies
        )
    }
}

