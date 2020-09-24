//
//  viewExt.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 22/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import Foundation
import UIKit
extension UIView {
    
    
    
    func makecircle()
    {
    self.layer.borderWidth = 1
    self.layer.masksToBounds = false
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.cornerRadius = self.frame.height/2
    self.clipsToBounds = true
    }
}
