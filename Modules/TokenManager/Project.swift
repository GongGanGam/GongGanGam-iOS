//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = "TokenManager"

let target = Project.makeFrameworkTarget(
    targetName: name,
    platform: .iOS,
    dependencies: []
)

let project = Project.makeProject(
    name: name,
    targets: [target]
)
