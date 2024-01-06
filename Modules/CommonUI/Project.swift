//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/5/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = "CommonUI"

let target = Project.makeFrameworkTarget(
    targetName: name,
    platform: .iOS,
    dependencies: [],
    useResources: true
)

let project = Project.makeProject(
    name: name,
    targets: [target]
)
