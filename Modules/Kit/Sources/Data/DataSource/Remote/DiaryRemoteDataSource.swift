//
//  DiaryRemoteDataSource.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/02/01.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import Combine
import Network

protocol DiaryRemoteDataSource {
    
    // MARK: Methods
    func fetchDetailDiary(diaryId: String) -> AnyPublisher<Diary, Error>
    func fetchMonthlyDiary(year: Int, month: Int) -> AnyPublisher<[Diary], Error>
    func writeDiary(diary: Diary, imageData: Data?) -> AnyPublisher<Diary, Error>
    func editDiary(diary: Diary, imageData: Data?) -> AnyPublisher<Diary, Error>
}

final public class DiaryRemoteDataSourceImpl: DiaryRemoteDataSource {

    // MARK: Properties
    private let networkManager: NetworkManager
    private let interceptor: RequestInterceptor
    
    // MARK: Initializers
    public init(
        networkManager: NetworkManager,
        interceptor: RequestInterceptor
    ) {
        self.networkManager = networkManager
        self.interceptor = interceptor
    }
    
    // MARK: Methods
    func writeDiary(diary: Diary, imageData: Data?) -> AnyPublisher<Diary, Error> {
        let dto = DiaryRequestDTO(
            date: diary.date.toString(type: .yearToDay),
            emoji: diary.emoji,
            content: diary.content,
            shareAgreed: diary.shareAgreed,
            image: imageData
        )
        
        let diaryEndpoint = DiaryMultipartEndpoint.create(dto: dto)
        
        return networkManager.request(
            with: diaryEndpoint,
            type: GenericDTO<DiaryResponseDTO>.self,
            interceptor: interceptor
        )
        .map { $0.data.toModel() }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
    
    func fetchDetailDiary(diaryId: String) -> AnyPublisher<Diary, Error> {
        let endpoint = DiaryEndpoint.fetchDetail(diaryId: diaryId)
        return networkManager.request(
            with: endpoint,
            type: GenericDTO<DiaryResponseDTO>.self,
            interceptor: self.interceptor
        )
        .map { $0.data.toModel() }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
    
    func fetchMonthlyDiary(year: Int, month: Int) -> AnyPublisher<[Diary], Error> {
        let endpoint = DiaryEndpoint.fetchDiary(year: year, month: month)
        return networkManager.request(
            with: endpoint,
            type: GenericDTO<[DiaryResponseDTO]>.self,
            interceptor: self.interceptor
        )
        .map { $0.data.map { $0.toModel() } }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }
    
    func editDiary(diary: Diary, imageData: Data?) -> AnyPublisher<Diary, Error> {
        guard let diaryId = diary.diaryId else {
            return Fail<Diary, Error>(error: KitError.noIdError as Error)
                .eraseToAnyPublisher()
        }
        let dto = DiaryRequestDTO(
            date: diary.date.toString(type: .yearToDay),
            emoji: diary.emoji,
            content: diary.content,
            shareAgreed: diary.shareAgreed,
            image: imageData
        )
        let endpoint = DiaryMultipartEndpoint.edit(dto: dto, diaryId: diaryId)
        return networkManager.request(
            with: endpoint,
            type: GenericDTO<DiaryResponseDTO>.self,
            interceptor: self.interceptor
        )
        .map { $0.data.toModel() }
        .mapError { $0 as Error }
        .eraseToAnyPublisher()
    }

}

struct dummyDTO {}
