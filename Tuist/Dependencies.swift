//
//  Dependencies.swift
//  Config
//
//  Created by kimchansoo on 2023/01/01.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.0")),
    .remote(url: "https://github.com/Juanpe/SkeletonView", requirement: .upToNextMajor(from: "1.7.0")),
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .branch("main")),
    .remote(url: "https://github.com/Alamofire/Alamofire.git", requirement: .upToNextMajor(from: "5.8.1"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
