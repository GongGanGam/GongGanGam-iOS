//
//  UserSession.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/19.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public struct UserSession: Codable {
    
    public enum Gender: String, Codable {
        case undefine
        case male
        case female
    }
    
    let nickname: String
    let birthYear: String
    let email: String
    let profileImage: URL
    let shareType: String
    let gender: Gender
    
    private enum CodingKeys: String, CodingKey {
        case nickname
        case birthYear
        case email
        case profileImage = "profImage"
        case shareType
        case gender
    }
}
