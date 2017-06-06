//
//  TouchRecognizer.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

public final class TouchRecognizer: UIGestureRecognizer {
    
    // MARK: Properties
    private let target: Target = Target()
    private var touchesOnView: Set<UITouch> = []
    
    // MARK: Callbacks
    public var touchesBeganCallback: (() -> ())?
    public var touchesMovedCallback: (() -> ())?
    public var touchesEndedCallback: (() -> ())?
    public var touchesCancelledCallback: (() -> ())?
    
    // MARK: init
    init() {
        super.init(target: target, action: #selector(Target.handle(touchGesture:)))
        cancelsTouchesInView = false
    }
    
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
    }
    
    // MARK: Public
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        defer {
            touches.forEach({ self.touchesOnView.insert($0) })
        }
        guard touchesOnView.isEmpty else {
            return
        }
        touchesBeganCallback?()
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        touchesMovedCallback?()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        touchesOnView.subtract(touches)
        guard touchesOnView.isEmpty else { return }
        touchesEndedCallback?()
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        touchesCancelledCallback?()
    }
    
    public override func reset() {
        
    }
    
    public override func ignore(_ touch: UITouch, for event: UIEvent) {
        
    }
    
    public override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    public override func canPrevent(_ preventedGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    // MARK: Private
    
}

fileprivate extension TouchRecognizer {
    
    class Target: NSObject {
        
        // MARK: Callbacks
        
        // MARK: Public
        func handle(touchGesture: TouchRecognizer) {
            
        }
        
    }
    
}
