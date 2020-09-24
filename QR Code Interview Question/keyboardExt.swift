//
//  keyboardExt.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 22/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import UIKit
import Foundation
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
