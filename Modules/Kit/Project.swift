//
//  Project.swift
//  GongGanGamManifests
//
//  Created by dio.zip on 1/5/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = "Kit"

let target = Project.makeFrameworkTarget(
    targetName: name,
    platform: .iOS,
    dependencies: [
        .Library.network
    ]
)

let project = Project.makeProject(
    name: name, targets: [target]
)
