//
//  MultipartFormData.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public struct MultipartFormData {
    
    private var data = Data()
    private let boundary: String
    private let boundaryData: Data?
    
    public init(boundary: String = UUID().uuidString) {
        let boundary = "Boundary-\(boundary)"
        
        self.boundary = boundary
        self.boundaryData = "--\(boundary)\r\n".data(using: .utf8)
    }
    
    public func appending(_ text: String, forKey key: String) -> MultipartFormData {
        var formData = self
        
        formData.data = formData.data
            .appending(boundaryData)
            .appending("Content-Disposition: form-data; name=\"\(key)\"")
            .appendingLineBreak(2)
            .appending(text)
            .appendingLineBreak()
            
        return formData
    }
    
    public func appending(_ texts: [String], forKey key: String) -> MultipartFormData {
        var formData = self
        
        texts.forEach { formData = formData.appending($0, forKey: key) }
        
        return formData
    }
    
    public func appending(_ image: Data?, forName name: String) -> MultipartFormData {
        guard let image else { return self }
        
        var formData = self
        
        formData.data = formData.data
            .appending(boundaryData)
            .appending("Content-Disposition: form-data; name=\"\(name)\"; filename=\"GongGanGam\(UUID().uuidString).jpeg\"")
            .appendingLineBreak()
            .appending("Content-Type: image/jpeg")
            .appendingLineBreak(2)
            .appending(image)
            .appendingLineBreak()
        
        return formData
    }
    
    /// `baseRequest`에 HTTP Method, multipart/form-data Header, HTTP Body를 추가하여 반환합니다.
    public func toURLRequest(baseRequest: URLRequest) -> URLRequest {
        var request = baseRequest
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = data.appending("--\(boundary)--\r\n")
        
        return request
    }
}

private extension Data {
    
    func appendingLineBreak(_ count: Int = 1) -> Data {
        var data = self
        
        for _ in 0..<count {
            data = data.appending("\r\n")
        }
        
        return data
    }
    
    func appending(_ string: String) -> Data {
        return self.appending(string.data(using: .utf8))
    }
    
    func appending(_ other: Data?) -> Data {
        var data = self
        guard let other else { return data }
        
        data.append(other)
        return data
    }
}
