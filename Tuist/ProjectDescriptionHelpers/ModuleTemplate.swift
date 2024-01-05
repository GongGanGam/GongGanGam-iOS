//
//  ModuleTemplate.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import Foundation
import ProjectDescription

extension Project {
    static func makeModuleFrameworks(
        name: String,
        platform: Platform,
        dependencies: [TargetDependency],
        isTestable: Bool
    ) -> [Target] {
        var moduleTarget = [makeFrameworkTarget(
            targetName: name,
            platform: platform,
            dependencies: dependencies)]
        
        if isTestable {
            let testTarget = makeTestTarget(
                name: name,
                platform: platform,
                dependencies: [.target(name: name)] + dependencies
            )
            
            moduleTarget.append(testTarget)
        }
        
        return moduleTarget
    }
}
