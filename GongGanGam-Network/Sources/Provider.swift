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
import TokenManager

public protocol Provider: AnyObject {
    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<T>
}


final class ProviderImpl: Provider {
    
    // MARK: Properties
    private let session: URLSession
    private let tokenManager: TokenManager

    // MARK: Initializers
    init(tokenManager: TokenManager) {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        self.session = URLSession(configuration: configuration)
        self.tokenManager = tokenManager
    }
    
    // MARK: Methods
    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<T> {
        return self.session.rx.response(request: urlRequest)
            .catch({ err in
                guard case let RxCocoaURLError.httpRequestFailed(response, _) = err else { return Observable.error(err) }
                if response.statusCode == 401 {
                    return self.retry(urlRequest: urlRequest)
                }
                return Observable.error(err)
            })
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .asSingle()
    }
    
    private func retry(urlRequest: URLRequest) -> Observable<(response: HTTPURLResponse, data: Data)> {
        guard let refreshToken = tokenManager.getToken(with: .refreshToken) else { return .error(NetworkError.noTokenError) }
        
        
    }
}
