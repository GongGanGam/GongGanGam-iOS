//
//  MockUserSession.swift
//  GongGanGam-Tests
//
//  Created by 김세영 on 2023/02/21.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
@testable import GongGanGam_Kit

extension UserSession: Equatable {
    
    static var mock: UserSession {
        return UserSession(
            nickname: "nickname",
            birthYear: "1998",
            email: "example@example.com",
            profileImage: URL(string: "https://www.example.com")!,
            shareType: "all",
            gender: .male
        )
    }
    
    public static func == (lhs: UserSession, rhs: UserSession) -> Bool {
        return (
            lhs.nickname == rhs.nickname &&
            lhs.birthYear == rhs.birthYear &&
            lhs.email == rhs.email &&
            lhs.profileImage == rhs.profileImage &&
            lhs.shareType == rhs.shareType &&
            lhs.gender == rhs.gender
        )
    }
}
