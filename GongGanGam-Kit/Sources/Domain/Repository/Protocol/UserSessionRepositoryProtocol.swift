//
//  UserSessionRepositoryProtocol.swift
//  GongGanGam
//
//  Created by 김세영 on 2023/02/19.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import RxSwift

public protocol UserSessionRepositoryProtocol {
    
    func fetch() -> Single<UserSession?>
}
