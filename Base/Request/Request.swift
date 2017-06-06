//
//  Request.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import ObjectMapper

public enum HTTPMethod: String {
    
    case get = "GET"
    case post = "POST"
    
}

public protocol Request: Mappable {
    
    associatedtype ResponseType: Response
    var httpMethod: HTTPMethod {get}
    var url: String {get}
    
}

public protocol Response: Mappable {
    
    var error: ResponseError? {get}
    
}

public struct ResponseError: Error {
    
    let code: Int
    let message: String
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
    
}

// Request for zavezu
public protocol ZRequest: Request {}

public protocol ZResponse: Response {
    
    var errorCode: Int? {get}
    var errorMessage: String? {get}
}

public extension ZResponse {
    
    public var error: ResponseError? {
        return ResponseError(code: errorCode ?? -1, message: errorMessage ?? "Internal server error")
    }
    
}
