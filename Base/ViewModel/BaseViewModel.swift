//
//  BaseViewModel.swift
//  Base
//
//  Created by Vladimir Kavlakan on 29/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

open class BaseViewModel: ViewModelProtocol {
    
    // MARK: Callbacks
    public var onError: ((Error?) -> ())?
    
    // MARK: init
    public init() {}
    
    deinit {
        Logger.log("\(type(of: self)).deinit", tag: .destructor)
    }
    
    // MARK: Public
    open func viewDidLoad() {}
    open func viewWillAppear(_ animated: Bool) {}
    open func viewWillDisappear(_ animated: Bool) {}
    
}
