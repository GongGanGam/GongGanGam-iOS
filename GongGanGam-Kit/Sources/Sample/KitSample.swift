//
//  KitSample.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxSwift
import GongGanGam_Network
import TokenManager


public final class KitSample {
    
    // MARK: Properties
    let diaryEndpoint: DiaryEndpoint
    let networkManager = NetworkManager()
    let tokenManager = KeychainTokenManager()
    let interceptor: GGGInterceptor
    let disposebag = DisposeBag()
    
    // MARK: Initializers
    public init() {
        let access = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZGVudGlmaWNhdGlvbiI6IjIzNTQ2NDg4MjQiLCJyb2xlIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiZ29uZ2dhbmdhbSIsImlkIjoxLCJleHAiOjE3MDY1OTM4MDgsImlhdCI6MTY3NTA1NzgwOH0.jW_oJxRo02_rqRzkonUzGk6nWFpZNV0HFlnOOxPWAIc"
        let refresh = "1"
        tokenManager.save(token: access, with: .accessToken)
        tokenManager.save(token: refresh, with: .refreshToken)
        self.interceptor = GGGInterceptor(tokenManager: tokenManager, networkManager: networkManager)
        self.diaryEndpoint = DiaryEndpoint.fetchDiary(year: 2023, month: 01)
        let stream: Single<DiaryResponseDTO>
        stream = networkManager.request(endpoint: self.diaryEndpoint, intercepter: interceptor)
        stream.subscribe { dto in
            print(dto)
        }
        .disposed(by: disposebag)
    }
    // MARK: Methods
}
