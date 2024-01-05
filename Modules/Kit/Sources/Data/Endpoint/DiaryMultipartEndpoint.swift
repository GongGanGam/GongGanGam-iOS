//
//  DiaryMultipartEndpoint.swift
//  GongGanGam
//
//  Created by kimchansoo on 2023/01/26.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import Network

enum DiaryMultipartEndpoint: Endpoint {
    
    case create(dto: DiaryRequestDTO)
    case edit(dto: DiaryRequestDTO, diaryId: Int64)
    
    // MARK: Properties
    
    var baseURL: URL? {
        return URL.baseUrl?.appendingPathComponent("diary")
    }
    
    var method: HTTPMethod {
        switch self {
        case .create:
            return .post
        case .edit:
            return .put
        }
    }
    
    var path: String? {
        switch self {
        case .create:
            return nil
        case .edit(_, let diaryId):
            return "\(diaryId)"
        }
    }
    
    var parameters: HTTPRequestParameter? { return nil }

    
    // MARK: Methods

    func toURLRequest() throws -> URLRequest {
        let urlRequest = try configureURLRequest()
        
        var formData = MultipartFormData()
        switch self {
        case let .create(dto):
            formData = formData
                .appending(dto.date, forKey: "date")
                .appending(dto.emoji, forKey: "emoji")
                .appending(dto.content, forKey: "content")
                .appending(dto.shareAgreed ? "true": "false" , forKey: "shareAgreed")
                .appending(dto.image, forName: "imgFile")
        case let .edit(dto, _):
            formData = formData
                .appending(dto.emoji, forKey: "emoji")
                .appending(dto.content, forKey: "content")
                .appending(dto.shareAgreed ? "true": "false" , forKey: "shareAgreed")
                .appending(dto.image, forName: "imgFile")
        }
        
        return formData.toURLRequest(baseRequest: urlRequest)
    }
    
    private func configureURLRequest() throws -> URLRequest {
        guard let baseURL else { throw NetworkError.invalidURL }
        
        var url = baseURL
        if let path {
            url = url.appendingPathExtension(path)
        }
        
        var request = URLRequest(url: url)
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        return request
    }
    
    private func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = .current
        formatter.locale = .current
        formatter.timeZone = .current
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter.string(from: date)
    }
}
