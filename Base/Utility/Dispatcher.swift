//
//  Dispatcher.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public final class Dispatcher {
    
    // MARK: Props
    private var actions: [String: Action] = [:]
    
    // MARK: init
    init() {}
    
    deinit {
        Logger.log("\(type(of: self)).deinit", tag: .destructor)
    }
    
    // MARK: Public
    public func scheduleTask(withIdentifier identifier: String,
                      withDelay delay: TimeInterval = 0,
                      inQueue queue: DispatchQueue = DispatchQueue.main,
                      _ action: @escaping (Completable) -> ()) {
        
        let action = Action(action: action, queue: queue, delay: delay, onComplete: nil)
        
        queue.async(flags: .barrier) { [weak self] in
            self?.actions[identifier] = action
            queue.asyncAfter(deadline: .now() + delay, flags: .barrier) { [weak self] in
                guard let delayedAction = self?.actions[identifier] else {return}
                guard delayedAction.identifier == action.identifier else {return}
                delayedAction.action(delayedAction)
            }
        }
    }
}

fileprivate extension Dispatcher {
    fileprivate struct Action: Completable {
        

        let identifier: String = NSUUID().uuidString
        var action: (Completable) -> ()
        var queue: DispatchQueue
        var delay: TimeInterval
        
        // MARK: Completable

        fileprivate var onComplete: ((CompletionCallback) -> ())?
    }
}
