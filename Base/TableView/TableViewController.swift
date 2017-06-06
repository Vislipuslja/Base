//
//  TableViewController.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol TableViewController: class {
    
    var numberOfSections: Int {get}
    func numberOfRows(in section: Int) -> Int
    func rowController(at indexPath: IndexPath) -> TableViewRowController
    
    var didReload: (() -> ())? {get set}
    
}
