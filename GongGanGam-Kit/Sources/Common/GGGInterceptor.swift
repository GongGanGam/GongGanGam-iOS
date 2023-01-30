//
//  GGGInterceptor.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import GongGanGam_Network
import TokenManager
import RxSwift

final class GGGInterceptor: RequestInterceptor {
    // MARK: UI
    
    // MARK: Properties
    private let tokenManager: TokenManager
    private let networkManager: NetworkManager
    
    private var accessToken: String? {
        get { tokenManager.getToken(with: .accessToken) }
        set {
            guard let newValue else { return }
            tokenManager.save(token: newValue, with: .accessToken)
        }
    }
    private var refreshToken: String? {
        tokenManager.getToken(with: .refreshToken)
    }
    
    // MARK: Initializers
    init(
        tokenManager: TokenManager,
        networkManager: NetworkManager
    ) {
        self.tokenManager = tokenManager
        self.networkManager = networkManager
    }
    
    // MARK: Methods
    
    func adapt(request: URLRequest) -> URLRequest {
        var request = request
        request.setValue(self.accessToken, forHTTPHeaderField: "accessToken")
        return request
    }
    
    func retry<T>(error: Error, urlRequest: URLRequest) -> Single<T> where T : Decodable {
        print("retry\n\n\n\n")
        guard let error = error as? NetworkError,
              case .invalidStatusCode(let status) = error,
              status == 401,
              let url = URL(string: "그.... 토큰 다시 받아오는 url")
        else { return .error(error) }
        
        var tokenUrlRequest = URLRequest(url: url)
        tokenUrlRequest.setValue(self.refreshToken, forHTTPHeaderField: "refreshToken")
        
        return networkManager.request(tokenUrlRequest, type: TokenDTO.self)
            .flatMap { [weak self] tokenDTO in
                guard let self else { return .error(NetworkError.unknown) }
                self.accessToken = tokenDTO.accessToken
                var urlRequest = urlRequest
                urlRequest.setValue(self.accessToken, forHTTPHeaderField: "accessToken")
                return self.networkManager.request(urlRequest, type: T.self)
            }
    }

}
