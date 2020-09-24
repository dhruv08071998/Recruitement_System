//
//  customeroundedtextview.swift
//  QR Code Interview Question
//
//  Created by Harsh Patel on 29/01/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable
class CustomView: UITextView{
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        
        didSet{
            
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    override func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
}
