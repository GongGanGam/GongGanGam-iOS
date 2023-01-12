//
//  Provider.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/09.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

public protocol Provider: AnyObject {
    
    func request<T: Decodable>(endpoint: Endpoint, intercepter: RequestInterceptor?) -> Single<T>
    func request<T: Decodable>(_ urlRequest: URLRequest, intercepter: RequestInterceptor?) -> Single<T>
}


final class ProviderImpl: Provider {
    
    // MARK: Properties
    private let session: URLSession
    
    static let `default` = ProviderImpl()

    // MARK: Initializers
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: Methods
    func request<T: Decodable>(endpoint: Endpoint, intercepter: RequestInterceptor? = nil) -> Single<T> {
        guard let req = try? endpoint.toURLRequest() else { return Single.error(NetworkError.invalidURL) }
        
        var requestUrl = req
        
        if let intercepter {
            requestUrl = intercepter.adapt(request: requestUrl)
        }
        
        return self.request(requestUrl, intercepter: intercepter)
    }
    
    func request<T: Decodable>(_ urlRequest: URLRequest, intercepter: RequestInterceptor? = nil) -> Single<T> {
        
        return self.session.rx.response(request: urlRequest)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .asSingle()
            .catch({ err in
                if let intercepter {
                    return intercepter.retry(error: err, urlRequest: urlRequest)
                }
                return .error(err)
            })
    }
}
