//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let projectName = "GongGanGam"

let appTarget = Target(
    name: projectName,
    platform: .iOS,
    product: .app,
    bundleId: "\(AppSetting.bundleIdPrefix).\(projectName)",
    deploymentTarget: AppSetting.deploymentTarget,
    infoPlist: .extendingDefault(
        with:
            ["CFBundleShortVersionString": "1.0",
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
    ),
    sources: ["Sources/**"],
    resources: ["Resources/**"],
    dependencies: [
        //        .ThirdParty.tca,
        .ThirdParty.Kingfisher,
        .ThirdParty.SkeletonView,
        
            .Library.commonUI,
        .Library.network,
        .Library.tokenManager,
        .Library.LocalDataBase,
        .Library.kit
    ],
    settings: .settings(
        base: ["GCC_PREPROCESSOR_DEFINITIONS[arch=*]": "FLEXLAYOUT_SWIFT_PACKAGE=1"],
        configurations: [.debug(name: .debug)]
    )
)

let project = Project.makeProject(
    name: AppSetting.appName,
    targets: [
        appTarget
    ]
)
