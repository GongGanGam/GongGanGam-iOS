//
//  Endpoint.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/11.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case `get` = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public typealias HTTPHeaders = [String: String]

public enum HTTPRequestParameter {
    case query([String: String])
    case body(Encodable)
}

public protocol Endpoint {
    var baseURL: URL? { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var path: String? { get }
    var parameters: HTTPRequestParameter? { get }
    
    func toURLRequest() throws -> URLRequest
}

public extension Endpoint {
    
    var headers: HTTPHeaders {
        return ["Content-Type": "application/json"]
    }
    
    func toURLRequest() throws -> URLRequest {
        guard let url = configureURL() else { throw NetworkError.invalidURL }
        return URLRequest(url: url)
            .appending(method: method)
            .appending(headers: headers)
            .appendingBody(with: parameters)
    }
    
    private func configureURL() -> URL? {
        return self.baseURL?.appendingPath(path: path)?.appendingQueries(at: parameters)
    }
}

extension URL {
    
    func appendingPath(path: String?) -> URL? {
        guard let path = path else { return self }
        return self.appendingPathComponent(path)
//        print(URL(string: path, relativeTo: self)?.absoluteString)
//        return URL(string: path, relativeTo: self)
    }
    
    func appendingQueries(at parameter: HTTPRequestParameter?) -> URL? {
        var components = URLComponents(string: self.absoluteString)
        if case .query(let queries) = parameter {
            let targetQueries = components?.queryItems ?? []
            components?.queryItems = targetQueries + queries.map { URLQueryItem(name: $0, value: $1) }
        }
        return components?.url
    }
}

private extension URLRequest {
    func appending(method: HTTPMethod) -> URLRequest {
        var urlRequest = self
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
    
    func appending(headers: HTTPHeaders) -> URLRequest {
        var urlRequest = self
        headers.forEach {
            urlRequest.addValue($1, forHTTPHeaderField: $0)
        }
        return urlRequest
    }
    
    func appendingBody(with parameter: HTTPRequestParameter?) -> URLRequest {
        var urlRequest = self
        if case .body(let body) = parameter {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }
        return urlRequest
    }
}

