//
//  Intercepter.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxSwift

typealias AcesstokenPusher = RequestAdapter
typealias TokenRefresher = RequestRetrier

public protocol RequestAdapter {
    func adapt(request: URLRequest) -> URLRequest
}

public protocol RequestRetrier {
    func retry(error: Error, urlRequest: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)>
}

public protocol RequestInterceptor: RequestAdapter, RequestRetrier {}

extension RequestInterceptor {
    
    public func adapt(request: URLRequest) -> URLRequest {
        return request
    }
    
    public func retry(error: Error, urlRequest: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        return Observable.error(error)
    }
}
