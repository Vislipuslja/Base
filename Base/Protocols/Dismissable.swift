//
//  Dismissable.swift
//  Base
//
//  Created by Vladimir Kavlakan on 25/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol Dismissable: class {
    
    var onDismiss: (() -> ())? {get set}
    
}
