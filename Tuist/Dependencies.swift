//
//  Dependencies.swift
//  Config
//
//  Created by kimchansoo on 2023/01/01.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/RxSwiftCommunity/RxFlow", requirement: .upToNextMajor(from: "2.10.0")),
    .remote(url: "https://github.com/layoutBox/FlexLayout", requirement: .upToNextMajor(from: "1.3.18")),
    .remote(url: "https://github.com/ReactorKit/ReactorKit", requirement: .upToNextMajor(from: "3.0.0")),
    .remote(url: "https://github.com/RxSwiftCommunity/RxGesture", requirement: .upToNextMinor(from: "4.0.0")),
    .remote(url: "https://github.com/onevcat/Kingfisher", requirement: .upToNextMajor(from: "7.0")),
    .remote(url: "https://github.com/Juanpe/SkeletonView", requirement: .upToNextMajor(from: "1.7.0"))
])

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
