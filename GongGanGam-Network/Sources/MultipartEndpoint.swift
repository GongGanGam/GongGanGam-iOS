//
//  MultipartEndpoint.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

// endpoint 만들기
// multipart 만들기
// toData 해서 데이터 받아오기
// param에 넣기
// header에 formdata로
// method post러
//

//TODO: 나중에 multipart 사용 간편하도록 endpoint 따로 구현해주기

protocol MultipartEndpoint: Endpoint {
    var multipartFormData: MultipartFormData { get set }
    
    //TODO: toURLRequest를 강제로 만들게 하고 싶은데 어떻게 해야하지
    func toURLRequest() throws -> URLRequest
}

extension MultipartEndpoint {
    
    var method: HTTPMethod { return .post }
    
    private func configureURLRequest() throws -> URLRequest {
        guard let baseURL,
              let appendUrl = baseURL.appendingPath(path: path)
        else { throw NetworkError.invalidURL }
        
        var request = URLRequest(url: appendUrl)
        
        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        return request
    }
}
