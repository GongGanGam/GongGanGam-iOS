//
//  NetworkError.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/09.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case invalidStatusCode(Int)
    case decodeError
    case noTokenError
    case invalidURL
}
