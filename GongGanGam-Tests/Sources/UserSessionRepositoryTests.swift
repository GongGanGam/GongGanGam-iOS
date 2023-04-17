//
//  UserSessionRepositoryTests.swift
//  GongGanGam-Tests
//
//  Created by 김세영 on 2023/02/20.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import XCTest
import RxSwift
@testable import GongGanGam_Network
@testable import GongGanGam_Kit

final class UserSessionRepositoryTests: XCTestCase {
    
    var userSessionRepository: UserSessionRepositoryProtocol!
    var networkManager: MockNetworkManager!
    var tokenManager: MockTokenManager!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        self.networkManager = MockNetworkManager()
        self.tokenManager = MockTokenManager()
        self.userSessionRepository = UserSessionRepository(
            networkManager: self.networkManager,
            tokenManager: self.tokenManager
        )
        self.disposeBag = DisposeBag()
    }
    
    func test_fetchNil_whenTokenNotExists() {
        // Given
        let expectation = expectation(description: #function)
        
        tokenManager.token = [:]
        networkManager.error = nil
        networkManager.result = UserSession.mock
        
        // When
        var receivedUserSession: UserSession? = .mock
        
        userSessionRepository.fetch()
            .subscribe { userSession in
                receivedUserSession = userSession
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        // Then
        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)
            XCTAssertNil(receivedUserSession)
        }
    }
    
    func test_fetchUserSession_whenFetchCalled() {
        // Given
        let expectation = expectation(description: #function)
        
        tokenManager.token = [.accessToken: "access-token"]
        networkManager.result = UserSession.mock
        
        // When
        var receivedUserSession: UserSession? = nil
        
        userSessionRepository.fetch()
            .subscribe { userSession in
                receivedUserSession = userSession
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        // Then
        waitForExpectations(timeout: 3) { error in
            XCTAssertNil(error)
            XCTAssertEqual(receivedUserSession, .mock)
        }
    }
}
