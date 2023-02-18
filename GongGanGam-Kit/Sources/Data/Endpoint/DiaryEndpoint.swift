//
//  DiaryEndpoint.swift
//  GongGanGam
//
//  Created by kimchansoo on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import GongGanGam_Network
import RxSwift

enum DiaryEndpoint: Endpoint {

    case fetchDetail(diaryId: String)
    case fetchDiary(year: Int, month: Int)
    case fetchShared(page: Int, pageSize: Int)
    
    var baseURL: URL? {
        return URL.baseUrl?.appendingPathComponent("diary")
    }
    
    var method: HTTPMethod { return .get }
    
    var path: String? {
        switch self {
        case .fetchDetail(let diaryId):
            return diaryId
        case .fetchShared:
            return "shared"
        case .fetchDiary:
            return nil
        }
    }
    
    var parameters: HTTPRequestParameter? {
        switch self {
        case let .fetchDiary(year, month):
            return .query(["year": "\(year)", "month": "\(month)"])
        case let .fetchShared(page, pageSize):
            return .query(["page":"\(page)", "size": "\(pageSize)"])
        default:
            return nil
        }
    }
    
}
