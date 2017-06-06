//
//  Reachability.swift
//  Base
//
//  Created by Vladimir Kavlakan on 29/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

import ReachabilitySwift

public protocol ReachabilityServiceDelegate: class {
    func serviceDidBecomeReachable(_ service: ReachabilityServiceProtocol)
    func serviceDidBecomeUnreachable(_ service: ReachabilityServiceProtocol)
}

public protocol ReachabilityServiceProtocol: class {
    var isEnabled: Bool {get}
    var isReachable: Bool {get}
}

public final class ReachabilityService: ReachabilityServiceProtocol {
 
    // MARK: Properties
    private var reachability: Reachability = Reachability()!
    private weak var delegate: ReachabilityServiceDelegate?
    
    public var isEnabled: Bool = false
    public var isReachable: Bool = false {
        didSet {
            guard isReachable != oldValue else { return }
            isReachable ?
                delegate?.serviceDidBecomeReachable(self) :
                delegate?.serviceDidBecomeUnreachable(self)
        }
    }
    
    // MARK: init
    public init(with delegate: ReachabilityServiceDelegate) {
        self.delegate = delegate
        reachability.whenReachable = { [weak self] reachability in
            self?.isReachable = true
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.isReachable = false
        }
        do {
            try reachability.startNotifier()
            isEnabled = true
        } catch {
            isReachable = true
        }
    }
}
