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
    let diaryDataSource: DiaryRemoteDataSourceImpl
    let networkManager = NetworkManager()
    let tokenManager = KeychainTokenManager()
    let interceptor: GGGInterceptor
    let disposebag = DisposeBag()
    
    // MARK: Initializers
    public init() {
        self.interceptor = GGGInterceptor(tokenManager: tokenManager, networkManager: networkManager)
        self.diaryDataSource = DiaryRemoteDataSourceImpl(
            networkManager: self.networkManager,
            interceptor: self.interceptor
        )
        self.tokenUpdate()
        
//        self.writeDiary()
        
        self.fetchMonthly()
            .subscribe { diary in
                print("성공")
                print("diary: \(diary)")
            } onFailure: { err in
                print("에러: \(err)")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposebag)
        
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
            .subscribe { diary in
                print("성공")
                print("diary: \(diary)")
            } onFailure: { err in
                print("에러: \(err)")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposebag)

    }
    
    private func fetchMonthly() -> Single<[Diary]> {
        let endpoint = DiaryEndpoint.fetchDiary(year: 2023, month: 2)
        return networkManager.request(endpoint: endpoint, intercepter: self.interceptor)
            .map { (dtos: [DiaryResponseDTO]) -> [Diary] in
                dtos.map { $0.toModel() }
            }
    }
}
