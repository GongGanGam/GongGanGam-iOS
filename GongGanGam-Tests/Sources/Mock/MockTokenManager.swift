//
//  MockTokenManager.swift
//  GongGanGam-Tests
//
//  Created by 김세영 on 2023/02/21.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
@testable import TokenManager

final class MockTokenManager: TokenManager {
    
    var token = [KeychainAccount: Token]()
    var saveResult = false
    var deleteResult = false
    
    func getToken(with key: KeychainAccount) -> Token? {
        return token[key]
    }
    
    func save(token: Token, with key: KeychainAccount) -> Bool {
        return saveResult
    }
    
    func deleteToken(with key: KeychainAccount) -> Bool {
        return deleteResult
    }
}
