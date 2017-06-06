//
//  UIViewControllerExtensions.swift
//  Base
//
//  Created by Vladimir Kavlakan on 25/05/2017.
//  Copyright © 2017 Vladimir Kavlakan. All rights reserved.
//

// MARK: - Presentable
extension UIViewController: Presentable {
    
    public func toPresent() -> UIViewController? {
        return self
    }
    
}

// MARK: - Init
public extension UIViewController {
    
    private class func createFrom<T: UIViewController>(storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    public class func from(storyboard: UIStoryboard) -> Self {
        let identifier = String(describing: self)
        return createFrom(storyboard: storyboard, identifier: identifier)
    }
    
}

// MARK: - Keyboard
public extension UIViewController {
    
    public func subscribeForKeybardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    public func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func handleKeyboard(_ notification: Notification) {}
    
    public func keyboardFrame(from notification: Notification) -> CGRect? {
        guard let userInfo = notification.userInfo else { return nil }
        guard let rect = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return nil }
        return rect
    }
    
    public func keyboardAnimationDuration(from notification: Notification) -> TimeInterval? {
        guard let userInfo = notification.userInfo else { return nil }
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else { return nil }
        return duration
    }
    
    public func keyboardAnimationCurve(from notification: Notification) -> UIViewAnimationCurve? {
        guard let userInfo = notification.userInfo else { return nil }
        guard let curveKey = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? Int else { return nil }
        guard let curve = UIViewAnimationCurve(rawValue: curveKey) else { return nil }
        return curve
    }

}

// MARK: - Buttons
public extension UIViewController {
    
    public func makeSideBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "navigation_side_bar_icon"), style: .plain, target: self, action: #selector(handleSideBarButtonItemTap(_:)))
    }
    
    public func handleSideBarButtonItemTap(_ button: UIBarButtonItem) {}
    
    public func makeCloseBarButtonItem() -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "navigation_close_icon"), style: .plain, target: self, action: #selector(handleCloseBarButtonItemTap(_:)))
    }
    
    public func handleCloseBarButtonItemTap(_ button: UIBarButtonItem) {
        
    }
    
}
