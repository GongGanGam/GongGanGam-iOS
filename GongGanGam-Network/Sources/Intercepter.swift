//
//  Intercepter.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxSwift

public protocol RequestAdapter {
    
    func adapt(request: URLRequest) -> URLRequest
}

public protocol RequestRetrier {

    func retry<T: Decodable>(error: Error, urlRequest: URLRequest) -> Single<T>
}

public protocol RequestInterceptor: RequestAdapter, RequestRetrier {}

extension RequestInterceptor {
    
    public func adapt(request: URLRequest) -> URLRequest {
        return request
    }
    
    public func retry<T: Decodable>(error: Error, urlRequest: URLRequest) -> Single<T> {
        return Single.error(error)
    }
}
