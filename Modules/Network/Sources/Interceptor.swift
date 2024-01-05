//
//  Interceptor.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import Combine

public protocol RequestAdapter {
    
    func adapt(request: URLRequest) -> URLRequest
}

public protocol RequestRetrier {

    func retry<T: Decodable>(error: Error, urlRequest: URLRequest) -> Future<T, NetworkError>
}

public protocol RequestInterceptor: RequestAdapter, RequestRetrier {}

extension RequestInterceptor {
    
    public func adapt(request: URLRequest) -> URLRequest {
        return request
    }
    
    public func retry<T: Decodable>(error: Error, urlRequest: URLRequest) -> Future<T, Error> {
        return .init { promise in
            promise(.failure(error))
        }
    }
}
