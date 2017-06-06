//
//  BaseViewController.swift
//  Base
//
//  Created by Vladimir Kavlakan on 29/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

open class BaseViewController: UIViewController {
    
    deinit {
        Logger.log("\(type(of: self)).deinit", tag: .destructor)
    }
    
}
