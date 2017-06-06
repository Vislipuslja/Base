//
//  UIColorExtensions.swift
//  Base
//
//  Created by Vladimir Kavlakan on 25/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public extension UIColor {
    
    public convenience init(_ red: Float, _ green: Float, _ blue: Float, _ alpha: Float = 1) {
        self.init(colorLiteralRed: red / 255, green: green / 255, blue: blue / 255  , alpha: alpha)
    }
    
}
