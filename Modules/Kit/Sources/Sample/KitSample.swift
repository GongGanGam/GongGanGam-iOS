//
//  KitSample.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/01/30.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import Network
import TokenManager
import Combine

public final class KitSample {
    
    // MARK: Properties
    let diaryDataSource: DiaryRemoteDataSourceImpl
    let networkManager = NetworkManager()
    let tokenManager = KeychainTokenManager()
    let interceptor: GGGInterceptor
    
    var cancellable: Set<AnyCancellable> = []
    
    // MARK: Initializers
    public init() {
        self.interceptor = GGGInterceptor(tokenManager: tokenManager, networkManager: networkManager)
        self.diaryDataSource = DiaryRemoteDataSourceImpl(
            networkManager: self.networkManager,
            interceptor: self.interceptor
        )
        self.tokenUpdate()
        
    }
    // MARK: Methods
    
    private func tokenUpdate() {
        let access = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZGVudGlmaWNhdGlvbiI6IjIzNTQ2NDg4MjQiLCJyb2xlIjpbIlJPTEVfQURNSU4iXSwiaXNzIjoiZ29uZ2dhbmdhbSIsImlkIjoxLCJleHAiOjE3MDY1OTM4MDgsImlhdCI6MTY3NTA1NzgwOH0.jW_oJxRo02_rqRzkonUzGk6nWFpZNV0HFlnOOxPWAIc"
        let refresh = "1"
        tokenManager.save(token: access, with: .accessToken)
        tokenManager.save(token: refresh, with: .refreshToken)
    }
    
    private func writeDiary() {
        let diary = Diary(
            date: Date(),
            emoji: "즐거워요",
            content: "나는 김형기이고, 지금 아주 즐겁습니다!",
            shareAgreed: true
        )
        diaryDataSource.writeDiary(diary: diary, imageData: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("disposed")
                case .failure(let failure):
                    print("에러: \(failure)")
                }
            }, receiveValue: { diary in
                print("성공")
                print("diary: \(diary)")
            })
            .store(in: &cancellable)
    }
    
    private func fetchMonthly() -> AnyPublisher<[Diary], Error> {
        let endpoint = DiaryEndpoint.fetchDiary(year: 2023, month: 2)
        return networkManager.request(with: endpoint, type: [DiaryResponseDTO].self, interceptor: interceptor)
            .map { $0.map { $0.toModel() } }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
