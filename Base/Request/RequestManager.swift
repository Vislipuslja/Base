//
//  RequestManager.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public final class RequestManager: NSObject {
    
    // MARK: Properties
    fileprivate(set) var urlSession: URLSession!
    fileprivate(set) var headers: [String: String] = [:]
    
    // MARK: init
    public override init() {
        super.init()
        
        let sessionConfiguration = URLSessionConfiguration.default
//        self.urlSession = URLSession(configuration: sessionConfiguration)
        self.urlSession = URLSession(configuration: sessionConfiguration,
                                     delegate: self,
                                     delegateQueue: OperationQueue.main)
    }
    
    // MARK: Public
    public func set(_ headers: [String: String]) {
        self.headers = headers
    }
    
    public func create<T: Request>(_ request: T) -> RequestObject<T> {
        return RequestObject(request: request, urlSession: urlSession, headers: headers)
    }
    
    public func invalidate() {
        urlSession.invalidateAndCancel()
    }
    
    // MARK: Private
    
}

// MARK: - URLSessionDelegate
extension RequestManager: URLSessionDelegate {}
