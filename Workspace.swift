//
//  WorkSpace.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let workspace = Workspace(
    name: AppSetting.appName,
    projects: [
        "Apps/**",
        "Modules/**/*"
    ]
)
