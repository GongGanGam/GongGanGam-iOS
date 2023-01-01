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
    
    var dependencies: [TargetDependency] = [
        .external(name: "RxSwift"),
        .external(name: "RxCocoa"),
        .external(name: "RxRelay"),
        .external(name: "RxGesture"),
    ]
    
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
        [
            Target(
                name: projectName,
                platform: .iOS,
                product: .app,
                bundleId: "com.tnzkm.\(projectName)",
                deploymentTarget: .iOS(targetVersion: "14.0", devices: [.iphone]),
                infoPlist: .extendingDefault(with: infoPlist),
                sources: ["\(projectName)/Sources/**"],
                resources: "\(projectName)/Resources/**",
                entitlements: "\(projectName).entitlements",
                scripts: [
//                    .pre(path: "Scripts/SwiftLintRunScript.sh", arguments: [], name: "SwiftLint"),
//                    .pre(path: "Scripts/UpdatePackageRunScript.sh", arguments: [], name: "OpenSource")
                ],
                dependencies: dependencies
//                environment: [
//                    "use_fake_repository": "false",
//                    "is_succeed_case": "false"
//                ]
            ),
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
    settings: factory.generateConfigurations(),
    targets: factory.generateTarget()
)
