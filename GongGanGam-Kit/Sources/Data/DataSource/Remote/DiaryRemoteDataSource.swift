//
//  DiaryRemoteDataSource.swift
//  GongGanGam-Kit
//
//  Created by kimchansoo on 2023/02/01.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxSwift
import GongGanGam_Network

protocol DiaryRemoteDataSource {
    
    // MARK: Methods
    func fetchDetailDiary(diaryId: String) -> Single<Diary>
    func fetchMonthlyDiary(year: Int, month: Int) -> Single<[Diary]>
    func writeDiary(diary: Diary, imageData: Data?) -> Single<Diary>
    func editDiary(diary: Diary, imageData: Data?) -> Single<Diary>
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
    func writeDiary(diary: Diary, imageData: Data?) -> Single<Diary> {
        
        let dto = DiaryRequestDTO(
            date: diary.date.toString(type: .yearToDay),
            emoji: diary.emoji,
            content: diary.content,
            shareAgreed: diary.shareAgreed,
            image: imageData
        )
        let diaryEndpoint = DiaryMultipartEndpoint.create(dto: dto)
        
        return networkManager.request(
            endpoint: diaryEndpoint,
            intercepter: self.interceptor
        ).map { (dto: GenericDTO) -> DiaryResponseDTO in
            return dto.data
        }.map { $0.toModel() }
    }
    
    func fetchDetailDiary(diaryId: String) -> Single<Diary> {
        let endpoint = DiaryEndpoint.fetchDetail(diaryId: diaryId)
        return networkManager.request(
            endpoint: endpoint,
            intercepter: self.interceptor
        )
        .debug("1")
        .map { (dto: GenericDTO) -> DiaryResponseDTO in
            return dto.data
        }
        .debug("2")
        .map { $0.toModel() }
    }
    
    func fetchMonthlyDiary(year: Int, month: Int) -> Single<[Diary]> {
        let endpoint = DiaryEndpoint.fetchDiary(year: year, month: month)
        return networkManager.request(
            endpoint: endpoint,
            intercepter: self.interceptor
        ).map { (dto: GenericDTO) -> [DiaryResponseDTO] in
            return dto.data
        }.map { $0.map { $0.toModel() } }
    }
    
    func editDiary(diary: Diary, imageData: Data?) -> Single<Diary> {
        guard let diaryId = diary.diaryId else { return .error(KitError.noIdError) }
        let dto = DiaryRequestDTO(
            date: diary.date.toString(type: .yearToDay),
            emoji: diary.emoji,
            content: diary.content,
            shareAgreed: diary.shareAgreed,
            image: imageData
        )
        let endpoint = DiaryMultipartEndpoint.edit(dto: dto, diaryId: diaryId)
        return networkManager.request(
            endpoint: endpoint,
            intercepter: self.interceptor
        ).map { (dto: GenericDTO) -> DiaryResponseDTO in
            return dto.data
        }.map { $0.toModel() }
    }

}

struct dummyDTO {}
