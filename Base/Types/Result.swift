//
//  Result.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public enum Result<T> {
    case success(T)
    case failure(Error?)
}
