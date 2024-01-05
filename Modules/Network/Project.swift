//
//  Network.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import Foundation
import ProjectDescription
import ProjectDescriptionHelpers

let name = "Network"

let target = Project.makeFrameworkTarget(
    targetName: "Network",
    platform: .iOS,
    dependencies: [
        .ThirdParty.Alamofire,
        .Library.tokenManager
    ]
)

let project = Project.makeProject(
    name: "Network",
    targets: [target]
)
