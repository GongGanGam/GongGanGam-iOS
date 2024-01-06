//
//  TokenDTO.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

struct TokenDTO: Codable {
    let refreshToken: String
    let accessToken: String
}
