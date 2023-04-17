//
//  UserSessionRepository.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/19.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import RxSwift
import GongGanGam_Network
import TokenManager

public final class UserSessionRepository: UserSessionRepositoryProtocol {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let tokenManager: TokenManager
    
    // MARK: - Initializer
    public init(
        networkManager: NetworkManager,
        tokenManager: TokenManager
    ) {
        self.networkManager = networkManager
        self.tokenManager = tokenManager
    }
    
    // MARK: - Methods
    public func fetch() -> Single<UserSession?> {
        guard let token = tokenManager.getToken(with: .accessToken) else {
            return .just(nil)
        }
        
        let endpoint = UserSessionEndpoint.getUserInfo
        var request: URLRequest
        
        do {
            request = try endpoint.toURLRequest()
            request.addValue(token, forHTTPHeaderField: "accessToken")
        } catch {
            return .error(error)
        }
        
        return networkManager
            .request(request, type: CommonResponse<UserSession>.self)
            .map(\.data)
    }
}
