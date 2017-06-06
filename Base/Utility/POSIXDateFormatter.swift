//
//  POSIXDateFormatter.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public final class POSIXDateFormatter {
    
    // MARK: Static
    private static let `default`: POSIXDateFormatter = POSIXDateFormatter()
    
    public static let PHPDateFormat: String = "yyyy-MM-dd HH:mm:ss"
    public static let NodeDateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    public static func date(from string: String?, format: String) -> Date? {
        guard let string = string else { return nil }
        POSIXDateFormatter.default.dateFormatter.dateFormat = format
        return POSIXDateFormatter.default.dateFormatter.date(from: string)
    }
    
    public static func string(from date: Date?, format: String) -> String? {
        guard let date = date else { return nil }
        POSIXDateFormatter.default.dateFormatter.dateFormat = format
        return POSIXDateFormatter.default.dateFormatter.string(from: date)
    }
    
    // MARK: Properties
    private let dateFormatter: DateFormatter = DateFormatter()
    
    // MARK: init
    private init() {
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    }
    
}
