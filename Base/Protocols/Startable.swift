//
//  Startable.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol Startable: class {
    
    var onStart: (() -> ())? {get set}
    
}
