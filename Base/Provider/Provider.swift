//
//  Provider.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol ProviderProtocol: class {
    
}

open class Provider {
    
    public var state: State = .initial
    
    public init() {
        
    }
    
}

public extension Provider {
    
    enum State {
        case initial
        case updating
        case updated
        case error(Error?)
    }
    
}

extension Provider.State: Equatable {
    
    public static func ==(lhs: Provider.State, rhs: Provider.State) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial),
             (.updating, .updating),
             (.updated, .updated),
             (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }
    
}
