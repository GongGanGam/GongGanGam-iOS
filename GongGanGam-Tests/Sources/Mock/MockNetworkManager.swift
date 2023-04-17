//
//  MockNetworkManager.swift
//  GongGanGam-UI
//
//  Created by 김세영 on 2023/02/20.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import RxSwift
@testable import GongGanGam_Kit
@testable import GongGanGam_Network

final class MockNetworkManager: NetworkManager {
    
    var result: Any?
    var error: Error?
    
    override func request<T>(endpoint: Endpoint, intercepter: RequestInterceptor? = nil) -> Single<T> where T : Decodable {
        return mockRequest()
    }
    
    override func request<T>(_ urlRequest: URLRequest, type: T.Type, intercepter: RequestInterceptor? = nil) -> Single<T> where T : Decodable {
        return mockRequest()
    }
    
    private func mockRequest<T>() -> Single<T> where T: Decodable {
        if let error {
            return .error(error)
        }
        
        guard let result = result as? T else {
            fatalError("MockNetworkManager: need must be not nil + result type should be T when error is nil.")
        }
        
        return .just(result)
    }
}
