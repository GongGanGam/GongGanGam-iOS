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

//public protocol Provider: AnyObject {
//
//    func request<T: Decodable>(endpoint: Endpoint, intercepter: RequestInterceptor?) -> Single<T>
//    func request<T: Decodable>(_ urlRequest: URLRequest, type: T.Type, intercepter: RequestInterceptor?) -> Single<T>
//}


public class NetworkManager {
    
    // MARK: Properties
    private let session: URLSession
    
//    static let `default` = ProviderImpl()

    // MARK: Initializers
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 100
        configuration.timeoutIntervalForResource = 100
        self.session = URLSession(configuration: configuration)
    }
    
    // MARK: Methods
    public func request<T: Decodable>(endpoint: Endpoint, intercepter: RequestInterceptor? = nil) -> Single<T> {
        guard let req = try? endpoint.toURLRequest() else { return Single.error(NetworkError.invalidURL) }
        
        var requestUrl = req
        
        if let intercepter {
            requestUrl = intercepter.adapt(request: requestUrl)
        }
        
        return self.request(requestUrl, type: T.self, intercepter: intercepter)
    }
    
    public func request<T: Decodable>(_ urlRequest: URLRequest, type: T.Type, intercepter: RequestInterceptor? = nil) -> Single<T> {
        
        return self.session.rx.response(request: urlRequest)
            .map { res in
                print(res)
                if (200...299) ~= res.response.statusCode {
                    return res.data
                }
                throw NetworkError.invalidStatusCode(res.response.statusCode)
            }
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
