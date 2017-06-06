//
//  RequestObject.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import ObjectMapper
import Alamofire

public enum NetworkError: Error {
    case internetConnctionIsNotReachable
    case urlIsInvalid
    case isNotHTTPURLResponse
    case invalidStatusCode(String)
    case invalidResponseData
    case invalidResponseJSON
    case invalidResponseMapping
    
    case internalServerError
}

public final class RequestObject<T: Request> {
    
    // MARK: Constants
    let defaultCachePolicy: URLRequest.CachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData
    let defaultTimeoutInterval: TimeInterval = 30
    
    // MARK: Properties
    fileprivate var timeoutInterval: TimeInterval?
    fileprivate var cachePolicy: URLRequest.CachePolicy?
    fileprivate var isLogging: Bool = false

    fileprivate let request: T
    fileprivate let urlSession: URLSession
    fileprivate var headers: [String: String]
    
    // MARK: init
    init(request: T, urlSession: URLSession, headers: [String: String]) {
        self.request = request
        self.urlSession = urlSession
        self.headers = headers
    }
    
    // MARK: Public
    public func set(timeoutInterval: TimeInterval?) -> RequestObject<T> {
        self.timeoutInterval = timeoutInterval
        return self
    }
    
    public func set(cachePolicy: URLRequest.CachePolicy?) -> RequestObject<T> {
        self.cachePolicy = cachePolicy
        return self
    }
    
    public func log() -> RequestObject<T> {
        isLogging = true
        return self
    }
    
    public func set(headers: [String: String]) -> RequestObject<T> {
        headers.forEach { (header: (key: String, value: String)) in
            self.headers.updateValue(header.value, forKey: header.key)
        }
        return self
    }
    
    public func response(_ completion: @escaping (Result<T.ResponseType>) -> ()) {
        let isLogging = self.isLogging
        do {
            let urlRequest = try createUrlRequest(for: request,
                                                  cachePolicy: cachePolicy,
                                                  timeoutInterval: timeoutInterval)
            let task = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
                guard let httpUrlResponse = urlResponse as? HTTPURLResponse else {
                    let error = NetworkError.isNotHTTPURLResponse
                    if isLogging {
                        Logger.log(error, tag: [.response, .error])
                    }
                    completion(Result<T.ResponseType>.failure(error))
                    return
                }
                guard 200..<300 ~= httpUrlResponse.statusCode else {
                    let error = NetworkError.invalidStatusCode(HTTPURLResponse.localizedString(forStatusCode: httpUrlResponse.statusCode))
                    if isLogging {
                        Logger.log(error, tag: [.response, .error])
                    }
                    completion(Result<T.ResponseType>.failure(error))
                    return
                }
                guard let data = data else {
                    let error = NetworkError.invalidResponseData
                    if isLogging {
                        Logger.log(error, tag: [.response, .error])
                    }
                    completion(Result<T.ResponseType>.failure(error))
                    return
                }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    guard JSONSerialization.isValidJSONObject(json) else {
                        let error = NetworkError.invalidResponseJSON
                        if isLogging {
                            Logger.log(error, tag: [.response, .error])
                        }
                        completion(Result<T.ResponseType>.failure(error))
                        return
                    }
                    guard let responseObject = Mapper<T.ResponseType>().map(JSONObject: json) else {
                        let error = NetworkError.invalidResponseMapping
                        if isLogging {
                            Logger.log(error, tag: [.response, .error])
                        }
                        completion(Result<T.ResponseType>.failure(error))
                        return
                    }
                    if isLogging {
                        Logger.log(json, tag: .response)
                    }
                    completion(Result<T.ResponseType>.success(responseObject))
                } catch {
                    completion(Result<T.ResponseType>.failure(error))
                }
            }
            task.resume()
        } catch {
            completion(Result<T.ResponseType>.failure(error))
        }
    }
    
    // MARK: Private
    private func createUrlRequest(for request: T, cachePolicy: URLRequest.CachePolicy?, timeoutInterval: TimeInterval?) throws -> URLRequest {
        
        if isLogging {
            Logger.log("\(request.url)", tag: .request)
        }
        
        guard let url = URL(string: request.url) else {
            let error = NetworkError.urlIsInvalid
            Logger.log(error, tag: [.request, .error])
            throw error
        }
        var urlRequest = URLRequest(url: url,
                                    cachePolicy: cachePolicy ?? defaultCachePolicy,
                                    timeoutInterval: timeoutInterval ?? defaultTimeoutInterval)
        headers.forEach { (header: (key: String, value: String)) in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        if isLogging {
            Logger.log(Mapper().toJSON(request), tag: .request)
        }
        
        switch request.httpMethod {
        case .get:
            let parameters = Mapper().toJSON(request)
            // TODO: temporary solution, needs custom query encoder
            urlRequest = try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        case .post:
            urlRequest.httpBody = Mapper().toJSONString(request)?.data(using: .utf8)
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}
