//
//  Database.swift
//  Base
//
//  Created by Vladimir Kavlakan on 25/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import RealmSwift

public final class Database {
    
    // MARK: Properties
    public let realm: Realm
    
    public init?() {
        do {
            realm = try Realm()
        } catch {
            return nil
        }
    }
    
    // MARK: Public
    
    
    // MARK: Private
    
}
