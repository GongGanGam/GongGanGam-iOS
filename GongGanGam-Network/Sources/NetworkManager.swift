//
//  Provider.swift
//  GongGanGam-Network
//
//  Created by kimchansoo on 2023/01/09.
//  Copyright © 2023 GongGanGam. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

//public protocol Provider: AnyObject {
//
//    func request<T: Decodable>(endpoint: Endpoint, intercepter: RequestInterceptor?) -> Single<T>
//    func request<T: Decodable>(_ urlRequest: URLRequest, type: T.Type, intercepter: RequestInterceptor?) -> Single<T>
//}


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
    
    // MARK: Methods
    public func request<T: Decodable>(
        endpoint: Endpoint,
        intercepter: RequestInterceptor? = nil
    ) -> Single<T> {
        guard let req = try? endpoint.toURLRequest() else { return Single.error(NetworkError.invalidURL) }
        print("urlrequest: \(req)")
        var requestUrl = req
        
        if let intercepter {
            requestUrl = intercepter.adapt(request: requestUrl)
        }
        
        return self.request(requestUrl, type: T.self, intercepter: intercepter)
    }
    
    public func request<T: Decodable>(
        _ urlRequest: URLRequest,
        type: T.Type,
        intercepter: RequestInterceptor? = nil
    ) -> Single<T> {    
        return self.session.rx.response(request: urlRequest)
            .map { res in
                print(res.data.prettyPrintedJSONString)
                if (200...299) ~= res.response.statusCode {
                    return res.data
                }
                throw NetworkError.invalidStatusCode(res.response.statusCode)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .asSingle()
            .catch({ err in
                if let intercepter {
                    return intercepter.retry(error: err, urlRequest: urlRequest)
                }
                return .error(err)
            })
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
