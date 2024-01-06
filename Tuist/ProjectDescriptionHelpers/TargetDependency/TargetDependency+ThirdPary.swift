//
//  TargetDependency+ThirdPary.swift
//  ProjectDescriptionHelpers
//
//  Created by dio.zip on 1/4/24.
//

import Foundation
import ProjectDescription

public extension TargetDependency.ThirdParty {
    static let tca = TargetDependency.external(name: "ComposableArchitecture")
    static let Kingfisher = TargetDependency.external(name: "Kingfisher")
    static let Collections = TargetDependency.external(name: "Collections")
    static let Toast = TargetDependency.external(name: "Toast")
    static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
    static let Firebase = TargetDependency.external(name: "Firebase")
    static let SkeletonView = TargetDependency.external(name: "SkeletonView")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
}
