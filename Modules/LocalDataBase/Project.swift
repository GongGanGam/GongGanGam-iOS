//
//  Project.swift
//  GongGanGamManifests
//
//  Created by dio.zip on 1/5/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = "LocalDataBase"

let target = Target(
    name: name,
    platform: .iOS,
    product: .framework,
    bundleId: "\(AppSetting.bundleIdPrefix).\(name)",
    deploymentTarget: AppSetting.deploymentTarget,
    infoPlist: .default,
    sources: "Sources/**/*",
    resources: nil,
    coreDataModels: [
        CoreDataModel("Sources/Example/ExStore.xcdatamodeld")
    ]
)

let project = Project.makeProject(
    name: name,
    targets: [
        target
    ]
)
