//
//  UserSessionEndpoint.swift
//  GongGanGam-Kit
//
//  Created by 김세영 on 2023/02/20.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import GongGanGam_Network

public enum UserSessionEndpoint: Endpoint {
    
    // MARK: - Endpoints
    case getUserInfo
    
    // MARK: - Properties
    public var baseURL: URL? {
        return URL.baseUrl?.appendingPathComponent("user")
    }
    
    public var method: HTTPMethod {
        switch self {
        case .getUserInfo:
            return .get
        }
    }
    
    public var path: String? {
        switch self {
        case .getUserInfo:
            return "info"
        }
    }
    
    public var parameters: HTTPRequestParameter? {
        switch self {
        case .getUserInfo:
            return nil
        }
    }
}
