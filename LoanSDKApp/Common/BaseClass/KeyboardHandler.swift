//
//  KeyboardHandler.swift
//  OpenAccountSDK
//
//  Created by consultant5 on 30/09/24.
//

import Foundation
import UIKit

protocol KeyboardHandlerDelegate: AnyObject {
    func keyboardWillShow(height: CGFloat)
    func keyboardWillHide()
}

class KeyboardHandler {
    
    static let shared = KeyboardHandler()
    
    private init() {
        setupKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        notifyDelegate(keyboardWillShow: keyboardHeight)
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        notifyDelegate(keyboardWillHide: ())
    }
    
    private func notifyDelegate(keyboardWillShow height: CGFloat) {
        NotificationCenter.default.post(name: .keyboardWillShow, object: nil, userInfo: ["height": height])
    }
    
    private func notifyDelegate(keyboardWillHide: ()) {
        NotificationCenter.default.post(name: .keyboardWillHide, object: nil)
    }
}

extension Notification.Name {
    static let keyboardWillShow = Notification.Name("KeyboardWillShow")
    static let keyboardWillHide = Notification.Name("KeyboardWillHide")
}
