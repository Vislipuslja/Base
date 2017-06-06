//
//  Coordinator.swift
//  Base
//
//  Created by Vladimir Kavlakan on 24/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol CoordinatorProtocol: class {
    
    var parent: CoordinatorProtocol? {get set}
    var coordinators: [CoordinatorProtocol] {get}
    
    func addDependency(_ coordinator: CoordinatorProtocol?)
    func removeDependency(_ coordinator: CoordinatorProtocol?)
    
    func start()
    func dismiss()
    
    var onFinish: (() -> ())? {get set}
    var onDismiss: ((CoordinatorProtocol?) -> ())? {get set}
    
}

open class Coordinator: CoordinatorProtocol {
    
    // MARK: Properties
    open weak var parent: CoordinatorProtocol?
    open var coordinators: [CoordinatorProtocol] = []
    
    // MARK: Callbacks
    open var onFinish: (() -> ())?
    open var onDismiss: ((CoordinatorProtocol?) -> ())?
    
    // MARK: init
    public init() {}
    
    deinit {
        Logger.log("\(type(of: self)).deinit", tag: .destructor)
    }
    
    // MARK: Public
    open func addDependency(_ coordinator: CoordinatorProtocol?) {
        guard let coordinator = coordinator else { return }
        guard coordinators.contains(where: { $0 === coordinator }) == false else { return }
        coordinators.append(coordinator)
        coordinator.parent = self
    }
    
    open func removeDependency(_ coordinator: CoordinatorProtocol?) {
        guard let coordinator = coordinator else { return }
        coordinators = coordinators.filter({ $0 !== coordinator })
    }
    
    open func start() {
        assertionFailure("must be overrided")
    }
    
    open func dismiss() {
        guard let parent = parent else {
            assertionFailure("parent is nil")
            return
        }
        parent.removeDependency(self)
    }
    
}
