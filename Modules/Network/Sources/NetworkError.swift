//
//  NetworkError.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/09.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public enum NetworkError: Error {
    /// 옳지 않은 URL
    case invalidURL
    /// response가 옳지 않을 때
    case invalidResponse
    /// 400 ~ 499에러 발생
    case badRequest
    /// 500
    case serverError
    /// Json으로 parsing 에러
    case parseError(String?)
    /// 알 수 없는 에러.
    case unknown
    case invalidRequest
}
