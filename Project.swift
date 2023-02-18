import ProjectDescription
import ProjectDescriptionHelpers


/*
                +-------------+
                |             |
                |     App     | Contains GongGanGamIOS App target and GongGanGamIOS unit-test target
                |             |
         +------+-------------+-------+
         |         depends on         |
         |                            |
 +----v-----+                   +-----v-----+
 |          |                   |           |
 |   Kit    |                   |     UI    |   Two independent frameworks to share code and start modularising your app
 |          |                   |           |
 +----------+                   +-----------+

 */


// MARK: - Project Factory
protocol ProjectFactory {
    var projectName: String { get }
    var dependencies: [TargetDependency] { get }
    
    func generateTarget() -> [Target]
    func generateConfigurations() -> Settings
}

final class BaseProjectFactory: ProjectFactory {
    var projectName: String = "GongGanGam"
    
    let dependencies: [TargetDependency] = [
        .external(name: "RxFlow"),
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxRelay"),
        .external(name: "RxGesture"),
        .external(name: "Kingfisher"),
        .external(name: "ReactorKit"),
//        .external(name: "FlexLayout"),
//        .external(name: "PinLayout"),
        .target(name: "GongGanGam-Kit"),
        .target(name: "GongGanGam-Network"),
        .target(name: "GongGanGam-UI"),
        .target(name: "GongGanGam-CoreData"),
        .target(name: "TokenManager"),
    ]
    
    let networkDependencies: [TargetDependency] = [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .target(name: "TokenManager")
    ]
    
    var mainTarget: Target {
        Target(
            name: projectName,
            platform: .iOS,
            product: .app,
            bundleId: "com.tnzkm.\(projectName)",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["\(projectName)/Sources/**"],
            resources: "\(projectName)/Resources/**",
            dependencies: dependencies,
            settings: .settings(base: ["GCC_PREPROCESSOR_DEFINITIONS[arch=*]": "FLEXLAYOUT_SWIFT_PACKAGE=1"], configurations: [.debug(name: .debug)])
        )
    }
    
    var kitTarget: Target {
        Target(
            name: "\(projectName)-Kit",
            platform: .iOS,
            product: .framework,
            bundleId: "com.tnzkm.\(projectName)-Kit",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["\(projectName)-Kit/Sources/**"]
        )
    }
    
    var networkKitTarget: Target {
        Target(
            name: "\(projectName)-Network",
            platform: .iOS,
            product: .framework,
            bundleId: "com.tnzkm.\(projectName)-Network",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["\(projectName)-Network/Sources/**"],
            dependencies: networkDependencies
        )
    }
    
    var gongGanGamUITarget: Target {
        Target(
            name: "\(projectName)-UI",
            platform: .iOS,
            product: .framework,
            bundleId: "com.tnzkm.\(projectName)-UI",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["\(projectName)-UI/Sources/**"],
            resources: ["\(projectName)-UI/Resources/**"],
            dependencies: [
                .package(product: "FlexLayout"),
                .package(product: "PinLayout"),
            ],
            settings: .settings(
                base: [
                    "GCC_PREPROCESSOR_DEFINITIONS[arch=*]": "FLEXLAYOUT_SWIFT_PACKAGE=1",
                ],
                configurations: [.debug(name: .debug)]
            )
        )
    }
    
    var tokenManagerTarget: Target {
        Target(
            name: "TokenManager",
            platform: .iOS,
            product: .framework,
            bundleId: "com.tnzkm.TokenManager",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["TokenManager/Sources/**"]
        )
    }
    
    var coreDataTarget: Target {
        Target(
            name: "\(projectName)-CoreData",
            platform: .iOS,
            product: .framework,
            bundleId: "com.tnzkm.\(projectName)-CoreData",
            deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
            infoPlist: .default,
            sources: ["\(projectName)-CoreData/Sources/**"],
            coreDataModels: [CoreDataModel("\(projectName)-CoreData/Sources/Example/ExStore.xcdatamodeld")]
        )
    }
    
    let infoPlist: [String: InfoPlist.Value] = [
        "CFBundleShortVersionString": "1.0",
        "CFBundleVersion": "1",
        "CFBundleDevelopmentRegion": "ko_KR",
        "UILaunchStoryboardName": "LaunchScreen",
        "UIUserInterfaceStyle": "Light",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "NSLocationAlwaysAndWhenInUseUsageDescription": "가까운 위치의 사용자를 파악하기 위해 위치 확인 권한이 필요합니다.",
        "NSCameraUsageDescription": "일기와 채팅에 첨부할 사진을 위해 카메라 권한이 필요합니다.",
        "NSPhotoLibraryUsageDescription": "일기와 채팅에 첨부할 사진을 위해 앨범 접근 권한이 필요합니다.",
        "CFBundleURLTypes" : ["App-prefs"],
        "UIAppFonts": [
            "Item 0": "Pretendard-Medium.otf",
            "Item 1": "Pretendard-Regular.otf",
            "Item 2": "Pretendard-SemiBold.otf",
            "Item 3": "Pretendard-Bold.otf"
        ]
    ]

    
    func generateTarget() -> [Target] {
        return [
            mainTarget,
            kitTarget,
            gongGanGamUITarget,
            networkKitTarget,
            tokenManagerTarget,
            coreDataTarget
        ]
    }
    
    func generateConfigurations() -> Settings {
        return Settings.settings(configurations: [
            .debug(name: "Debug", xcconfig: .relativeToRoot("\(projectName)/Sources/Config/Debug.xcconfig")),
            .release(name: "Release", xcconfig: .relativeToRoot("\(projectName)/Sources/Config/Release.xcconfig")),
        ])
    }
}

// MARK: - Project
let factory = BaseProjectFactory()

let project: Project = .init(
    name: factory.projectName,
    organizationName: factory.projectName,
    packages: [
        .package(url: "https://github.com/layoutBox/FlexLayout.git", .upToNextMajor(from: "1.3.18")),
        .package(url: "https://github.com/layoutBox/PinLayout.git", .branch("master")),
    ],
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
