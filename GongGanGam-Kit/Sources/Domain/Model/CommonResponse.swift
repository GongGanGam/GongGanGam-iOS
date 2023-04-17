//
//  CommonResponse.swift
//  GongGanGam-Kit
//
//  Created by 김세영 on 2023/02/20.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

struct CommonResponse<T>: Decodable where T: Decodable {
    
    let success: Bool
    let status: Int
    let code: Int
    let message: String
    let data: T?
}
