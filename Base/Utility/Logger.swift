//
//  Logger.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import Foundation

public final class Logger {
    
    public struct Tag: OptionSet, CustomStringConvertible {
        
        public var rawValue: Int
        
        public static let notification: Tag = Logger.Tag(rawValue: 1 << 0)
        public static let destructor: Tag = Logger.Tag(rawValue: 1 << 1)
        public static let request: Tag = Logger.Tag(rawValue: 1 << 2)
        public static let response: Tag = Logger.Tag(rawValue: 1 << 3)
        
        public static let error: Tag = Logger.Tag(rawValue: 1 << 14)
        public static let fatalError: Tag = Logger.Tag(rawValue: 1 << 15)
        
        public static let any: Tag = Logger.Tag(rawValue: 1 << 16)
        public static let measurement: Tag = Logger.Tag(rawValue: 1 << 17)
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        // MARK: CustomStringConvertible
        public var description: String {
            switch self {
            case Tag.notification:
                return "[Notification]"
            case Tag.destructor:
                return "[Destructor]"
            case Tag.request:
                return "[Request]"
            case Tag.response:
                return "[Response]"
            case Tag.error:
                return "[Error]"
            case Tag.fatalError:
                return "[FatalError]"
            case Tag.any:
                return "[Any]"
            default:
                return String()
            }
        }
        
        var stringRepresentation: String {
            return String()
        }
    }
    
    public static func log(_ items: Any?..., tag: Tag = .any, separator: String = String(), terminator: String = "\n") {
        var result: String = String()
        let defaultSeparator = separator == String() ? ", " : separator
        
        for (index, item) in items.enumerated() {
            guard let item = item else { continue }
            if index > 0 {
                result += defaultSeparator
            }
            result += String(describing: item)
        }
        
        print(result, separator: separator, terminator: terminator)
    }
    
    public static func measure(_ action: () -> ()) {
        let start = Date()
        action()
        Logger.log("action takes: \(Date().timeIntervalSince(start))", tag: .measurement)
    }
}
