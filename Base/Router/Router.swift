//
//  Router.swift
//  Base
//
//  Created by Vladimir Kavlakan on 23/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

public protocol RouterProtocol: Presentable {
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)
    
    func push(_ module: Presentable?)
    func push(_ module: Presentable?, animated: Bool)
    func push(_ module: Presentable?, animated: Bool, completion: (() -> ())?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> ())?)
    
    func setRootModule(_ module: Presentable?)
    func setRootModule(_ module: Presentable?, animated: Bool)
    func popToRootModule(animated: Bool)
}

public final class Router: NSObject, RouterProtocol {
    
    // MARK: Properties
    fileprivate weak var navigationController: UINavigationController?
    
    public func toPresent() -> UIViewController? {
        return navigationController
    }
    
    fileprivate var completions: [UIViewController : () -> ()] = [:]
    
    // MARK: init
    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
    }
    
    // MARK: Router
    
    public func present(_ module: Presentable?) {
        present(module, animated: true)
    }
    
    public func present(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        navigationController?.present(controller, animated: animated, completion: nil)
    }
    
    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: (() -> ())?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    public func push(_ module: Presentable?) {
        push(module, animated: true)
    }
    
    public func push(_ module: Presentable?, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    public func push(_ module: Presentable?, animated: Bool, completion: (() -> ())?) {
        guard
            let controller = module?.toPresent(),
            controller is UINavigationController == false
            else { return }
        if let completion = completion {
            completions[controller] = completion
        }
        navigationController?.pushViewController(controller, animated: animated)
    }
    
    public func popModule() {
        popModule(animated: true)
    }
    
    public func popModule(animated: Bool) {
        if let controller = navigationController?.popViewController(animated: animated) {
            runCompletion(for: controller)
            //            removeAnimator(for: controller)
        }
    }
    
    public func setRootModule(_ module: Presentable?) {
        setRootModule(module, animated: false)
    }
    
    public func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        navigationController?.setViewControllers([controller], animated: animated)
    }
    
    public func popToRootModule(animated: Bool) {
        if let controllers = navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach({ (controller) in
                runCompletion(for: controller)
                //                removeAnimator(for: controller)
            })
        }
    }
    
    // MARK: Private
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}
