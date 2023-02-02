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
        // swagger에서 status, code, message같은 애들이 추가적으로 붙는데 그 아이들을 DTO 자체에 포함을 시켜버릴지, 아니면 다른 처리(adaptor사용 등)를 통해서 처리를 할지
        return networkManager.request(
            endpoint: diaryEndpoint,
            intercepter: self.interceptor
        ).map { (dto: DiaryResponseDTO) -> Diary in
            dto.toModel()
        }
    }
    
    func fetchDetailDiary(diaryId: String) -> Single<Diary> {
        let endpoint = DiaryEndpoint.fetchDetail(diaryId: diaryId)
        return networkManager.request(endpoint: endpoint)
            .map { (dto: DiaryResponseDTO) -> Diary in
                dto.toModel()
            }
    }
    
    func fetchMonthlyDiary(year: Int, month: Int) -> Single<[Diary]> {
        let endpoint = DiaryEndpoint.fetchDiary(year: year, month: month)
        return networkManager.request(endpoint: endpoint)
            .map { (dtos: [DiaryResponseDTO]) -> [Diary] in
                dtos.map { $0.toModel() }
            }
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
        // 따로 받을 response가 없는데 해당 부분 어떻게 처리할지 고민해봐야할듯
        return networkManager.request(endpoint: endpoint)
            .map { (dto: DiaryResponseDTO) -> Diary in
                dto.toModel()
            }
    }

}

struct dummyDTO {}
