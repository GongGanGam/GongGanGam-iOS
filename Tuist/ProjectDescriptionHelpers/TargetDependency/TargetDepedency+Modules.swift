//
//  TargetDepedency+Modules.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/5/24.
//

import Foundation
import ProjectDescription

public extension TargetDependency.Library {
    static let network = TargetDependency.project(
        target: "Network",
        path: .relativeToRoot("Modules/Network")
    )
    
    static let tokenManager = TargetDependency.project(
        target: "TokenManager",
        path: .relativeToRoot("Modules/TokenManager")
    )
    
    static let commonUI = TargetDependency.project(
        target: "CommonUI",
        path: .relativeToRoot("Modules/CommonUI")
    )
    
    static let kit = TargetDependency.project(
        target: "Kit",
        path: .relativeToRoot("Modules/Kit")
    )
    
    static let LocalDataBase = TargetDependency.project(
        target: "LocalDataBase",
        path: .relativeToRoot("Modules/LocalDataBase")
    )
}
