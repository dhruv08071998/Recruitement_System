//
//  alertExtension.swift
//  alertDemo
//
//  Created by Harsh Patel on 22/03/19.
//  Copyright © 2019 Harsh Patel. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func showalert ( title : String  , message : String , handlerOk: @escaping ((UIAlertAction)->Void))//, handlerCancel:@escaping ((UIAlertAction)->Void))
    {
        let alert = UIAlertController (title: title , message: message, preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "Ok" , style: .cancel, handler: handlerOk)
        //let cancleAlert = UIAlertAction(title: "Cancel", style: .destructive , handler: handlerCancel)
        alert.addAction(okAlert)
       // alert.addAction(cancleAlert)
        
            self.present(alert, animated: true, completion: nil)
    }
    
}
