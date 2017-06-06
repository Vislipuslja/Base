//
//  TableViewSectionController.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol TableViewSectionController: class {
    
    associatedtype Row: TableViewRowController
    var rows: [Row] {get}
    
}
