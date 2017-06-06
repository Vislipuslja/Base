//
//  ViewModel.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol ViewModelProtocol: class {
    
    var onError: ((Error?) -> ())? {get set}
    
    func viewDidLoad()
    func viewWillAppear(_ animated: Bool)
    func viewWillDisappear(_ animated: Bool)
    
}
