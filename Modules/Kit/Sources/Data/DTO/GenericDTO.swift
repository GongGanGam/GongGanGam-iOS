//
//  GeneralDTO.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/02/02.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

struct GenericDTO<T: Decodable>: Decodable {
    var status: Int
    var code: Int
    var message: String
    var data: T
}
