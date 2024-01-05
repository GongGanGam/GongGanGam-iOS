//
//  Provider.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/09.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation
import Combine
import Alamofire

public protocol Provider: AnyObject {
    func request<T: Decodable>(endpoint: Endpoint, interceptor: RequestInterceptor?) -> Future<T, NetworkError>
    func request<T: Decodable>(_ urlRequest: URLRequest, type: T.Type, interceptor: RequestInterceptor?) -> Future<T, NetworkError>
}


public class NetworkManager {
    
    // MARK: Properties
    private let session: URLSession
    
    //    static let `default` = ProviderImpl()
    
    // MARK: Initializers
    public init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        self.session = URLSession(configuration: configuration)
    }
    
    public func request<T: Decodable>(with endpoint: Endpoint, type: T.Type, interceptor: RequestInterceptor? = nil) -> AnyPublisher<T, NetworkError> {
        guard let urlRequest = try? endpoint.toURLRequest() else {
            return Fail<T, NetworkError>(error: .invalidURL).eraseToAnyPublisher()
        }
        return self.request(urlRequest, interceptor: interceptor)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { $0 as? NetworkError ?? .parseError($0.localizedDescription) }
            .eraseToAnyPublisher()
    }
    
    public func request(_ request: URLRequest, interceptor: RequestInterceptor?) -> AnyPublisher<Data, NetworkError> {
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response in
                guard let self, let urlResponse = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                let verifiedResult = self.verify(data: data, urlResponse: urlResponse)
                
                switch verifiedResult {
                case .success(let data):
                    return data
                case .failure(let error):
                    throw error
                }
            }
            .mapError { error -> NetworkError in
                return error as? NetworkError ?? .parseError(error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
    
    func verify(data: Data?, urlResponse: HTTPURLResponse) -> Result<Data, NetworkError> {
        switch urlResponse.statusCode {
        case 200...299:
            if let data {
                return .success(data)
            } else {
                return .failure(NetworkError.unknown)
            }
        case 400...499:
            return .failure(NetworkError.badRequest)
        case 500...599:
            return .failure(NetworkError.serverError)
        default:
            return .failure(NetworkError.unknown)
        }
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
