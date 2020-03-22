//
//  TextViewController.swift
//  SelectedTextView
//
//  Created by Kilian on 21.03.20.
//  Copyright © 2020 Kilian. All rights reserved.
//

import SwiftUI

protocol SelectedTextViewControllerDelegate {
    func keyboardHeightDidChange(height: CGFloat)
}
class SelectedTextViewController: UIViewController {
    
    var delegate: SelectedTextViewControllerDelegate?
    
    let textView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .red
        return $0
    }(UITextView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        textView.becomeFirstResponder()
        textView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setupViews() {
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc fileprivate func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
            delegate?.keyboardHeightDidChange(height: keyboardHeight)
        }
    }
    
    @objc fileprivate func keyboardDidHide(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
            delegate?.keyboardHeightDidChange(height: keyboardHeight)
        }
    }
}

extension SelectedTextViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        
        let heightConstraint = self.textView.constraints.first(where: {
            $0.firstAttribute == .height
        })
        heightConstraint?.constant = min(newSize.height, view.frame.height)
    }
}
